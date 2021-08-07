import 'dart:io';
import 'dart:convert';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/legalattest/gallery/browserPhoto.dart';
import 'package:lianmiapp/pages/legalattest/page/models.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/lottery_pay_page.dart';
import 'package:lianmiapp/pages/product/page/prize_page.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/product/utils/lottery_utils.dart';
import 'package:lianmiapp/pages/product/widget/order_detail_list_widget.dart';
import 'package:lianmiapp/pages/me/events/qr_events.dart';
import 'package:lianmiapp/pages/me/page/recharge_page.dart';
import 'package:lianmiapp/pages/order/widgets/order_detail_status_widget.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'antchain_qr_page.dart';

class OrderDetailPage extends StatefulWidget {
  OrderModel order;

  OrderDetailPage(this.order);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with QrEvents
    implements LinkMeManagerOrderStatusListerner {
  List _selectedNums = [];

  List<String> _localUrls = []; //交互图片数组对应的本地完整路径
  List<ImageBean> imageList = [];

  int _fee = 0; //以分为单位
  int _prize = 0; //中奖金额 以分为单位

  String _qrcodeUrl = '';

  int _balance = 0;

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
    _reloadLocalPhotoUrls();

    _loadSelectNums();
    _loadImageIfDone(); //加载拍照图片
  }

  addTestData(String targetFileName) {
    if (_localUrls.contains(targetFileName) == false) {
      _localUrls.add(targetFileName);
    } else {
      logW('addTestData 图片已在数组内');
    }
  }

  List<ImageBean> getTestData() {
    List<ImageBean> list = [];
    for (int i = 0; i < _localUrls.length; i++) {
      String url = _localUrls[i];
      if (url.split('.').last == 'pdf') {
        list.add(ImageBean(
          originPath: url,
          middlePath: url,
          thumbPath: 'pdf',
          originalWidth: i == 0 ? 264 : null,
          originalHeight: i == 0 ? 258 : null,
          fileExtent: url.split('.').last,
        ));
      } else {
        list.add(ImageBean(
          originPath: url,
          middlePath: url,
          thumbPath: url,
          originalWidth: i == 0 ? 264 : null,
          originalHeight: i == 0 ? 258 : null,
          fileExtent: url.split('.').last,
        ));
      }
    }
    return list;
  }

  _reloadLocalPhotoUrls() async {
    if (widget.order.photos != null) {
      _localUrls = [];

      widget.order.photos!.forEach((fileUrl) async {
        String? _localFile = await appManager.getOrderImages(fileUrl);
        logI('_localFile: $_localFile');
        addTestData(_localFile!);
      });
      //TODO 目的是等待上面处理完成
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        imageList = getTestData();
        logI('_reloadLocalPhotoUrls :  ${imageList.length}');

        imageList.forEach((bean) {
          logI('_reloadLocalPhotoUrls, thumbPath : ${bean.thumbPath}');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductModel? product =
        LotteryData.instance.getProduct(widget.order.loterryType!);
    int count = widget.order.count!;
    int multiple = widget.order.multiple!;
    int price = product!.productPrice! * count * multiple; //总价

    //首次必须计算上链服务费
    if (_fee == 0) {
      _calculateOrderPrice(widget.order.cost!);
    }
    String totalPrice = '';

    if (App.isShop) {
      totalPrice = (price / 100).toStringAsFixed(1); //商户不需要合计上链服务费
    } else {
      totalPrice = (_fee / 100 + price / 100).toStringAsFixed(1); //合计
    }

    String payModeStr = '';
    if (widget.order.payMode == 1) {
      payModeStr = '微信';
    } else {
      payModeStr = '支付宝';
    }

    imageList = getTestData();

    // logI('build, _imageCount :  ${imageList.length}');
    // imageList.forEach((bean) {
    //   logI('build, thumbPath : ${bean.thumbPath}');
    // });

    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '订单详情',
          actions: [
            widget.order.status != null
                ? TextButton(
                    onPressed: () {
                      _showMedia(action: 1);
                    },
                    child: Text("+"),
                  )
                : SizedBox()
          ],
        ),
        backgroundColor: Color(0XEEEEEEEE),
        body: SafeArea(
            child: Container(
          child: ListView(
            children: [
              _ticketCodeItem(),
              _descWidget(),
              //TODO 暂时屏蔽
              OrderDetailListWidget(_selectedNums),
              Gaps.vGap20,
              _commonItem('商户名称', '${widget.order.shopName}'),
              _commonItem('总价', '${widget.order.cost!}元'),
              _commonItem('商品', '${product.productName}'),
              _commonItem('总价', '${widget.order.cost!}元'),

              _feeWidget(_fee),
              _commonItem('合计', '${totalPrice}元'),
              _commonItem('支付方式', '${payModeStr}'),

              _orderIDWidget(),
              _orderTimeArea(),
              widget.order.status != null
                  ? _photosArea()
                  : SizedBox(), //双方图片交互区
              _statusArea(),
              _bottomArea()
            ],
          ),
        )));
  }

  Widget _ticketCodeItem() {
    if (widget.order.ticketCode != null && widget.order.ticketCode! > 0) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.px),
        width: double.infinity,
        height: 72.px,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.order.ticketCode}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28.px,
                  decoration: widget.order.status == OrderStateEnum.OS_Refuse
                      ? TextDecoration.lineThrough
                      : null),
            ),
            CommonText(
              '出票码',
              fontSize: 14.px,
              color: Color(0XFF666666),
            )
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _descWidget() {
    ProductModel? product =
        LotteryData.instance.getProduct(widget.order.loterryType!);
    if (isValidString(product!.productDesc)) {
      return Container(
        padding: EdgeInsets.fromLTRB(16.px, 8.px, 16.px, 0.px),
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: CommonText(
          product.productDesc!,
          fontSize: 14.px,
          color: Color(0XFF535252),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _commonItem(String title, String desc, {EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.only(left: 30.px, right: 30.px),
      width: double.infinity,
      height: 48.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            title,
            fontSize: 16.px,
          ),
          Gaps.hGap16,
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: CommonText(
              desc,
              fontSize: 16.px,
              color: Color(0XFF666666),
              maxLines: 1,
            ),
          ))
        ],
      ),
    );
  }

  //交互图片区
  Widget _photosArea() {
    return Container(
      margin: EdgeInsets.only(top: 20.px),
      // padding: EdgeInsets.fromLTRB(23.px, 0, 23.px, 16.px),
      padding: EdgeInsets.fromLTRB(1.px, 0, 1.px, 1.px),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          _ninePhotosArea(context),
        ],
      ),
    );
  }

  Widget _ninePhotosArea(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        });
  }

  Widget getBrowserWidget(
      BuildContext context, String url, void Function() callback,
      {String? originPath}) {
    logI('getBrowserWidget: $url');

    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Image.file(File(url), fit: BoxFit.cover),
      ),
      onTap: () {
        logD('file hit!, url: $url');

        AppNavigator.push(context, BrowserPhoto(url)).then((value) {
          //TODO
        });
      },
    );
  }

  Widget _buildItem(BuildContext context, int _index) {
    int itemCount = _localUrls.length;

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 0.33, color: Color(0xffe5e5e5)))),
      padding: EdgeInsets.all(0),
      child: NineGridView(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(5),
        space: 5,
        type: NineGridType.weChat,
        color: Color(0XFFE5E5E5),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          ImageBean bean = imageList[index]; //图片数组

          return getBrowserWidget(context, _localUrls[index], () {
            logW('BrowserNineGridViewPage _buildItem callback');

            setState(() {});
          }, originPath: bean.originPath!); //如果pdf则用assets
        },
      ),
    );
  }

  Widget _feeWidget(int fee) {
    if (App.isShop) {
      return SizedBox();
    } else {
      return _commonItem(
          '上链服务费', fee <= 0 ? '0' : '${(fee / 100).toStringAsFixed(2)}元');
    }
  }

  Widget _orderIDWidget() {
    if (isValidString(widget.order.orderID)) {
      String orderID = widget.order.orderID!.replaceAll('-', '');
      return _commonItem('商户单号', '$orderID');
    } else {
      return SizedBox();
    }
  }

  Widget _orderTimeArea() {
    if (isValidString(widget.order.orderID)) {
      return _commonItem('下单时间',
          '${DateTimeUtils.orderTimeFromTimestamp(widget.order.orderTime!)}');
    } else {
      return SizedBox();
    }
  }

  Widget _statusArea() {
    return OrderDetailStatusWidget(
        loterryType: widget.order.loterryType ?? 0,
        status: widget.order.status ?? OrderStateEnum.OS_Undefined,
        prize: widget.order.prize ?? 0);
  }

  Widget _bottomArea() {
    if (App.isShop) {
      switch (widget.order.status) {
        case OrderStateEnum.OS_Prepare:
          {
            return _shopTakeOrder();
          }
        case OrderStateEnum.OS_Taked:
          {
            return _detailBottomButton('请留意查收客户是否付款', onTap: () {});
          }
        case OrderStateEnum.OS_IsPayed:
          {
            return _shopBottom();
          }
        case OrderStateEnum.OS_UpChained: //上链成功
          {
            return _shopPrizeBottom();
          }
        case OrderStateEnum.OS_Confirm:
          {
            return _shopPrizeBottom();
          }
        case OrderStateEnum.OS_Prizeed: //商户发起兑奖动作,通知用户上传收款码
          {
            if (widget.order.prize! > 0) {
              return _detailBottomButton('等待用户发起收款', onTap: () {});
            } else {
              return _detailBottomButton('未中奖', onTap: () {});
            }
          }

        case OrderStateEnum.OS_AcceptPrizeed: //商户收到用户上传的收款码
          {
            if (widget.order.prize! > 0) {
              return _detailBottomButton('通知用户已付款', onTap: () {
                _changeOrderAcceptPrizeed();
              });
            } else {
              return _detailBottomButton('未中奖', onTap: () {});
            }
          }
        default:
          return SizedBox();
      }
    } else {
      if (widget.order.status == null) {
        if (_balance >= _fee) {
          return _detailBottomButton('立即下单', topMargin: 40.px, onTap: () {
            AppNavigator.push(
                context,
                LotteryPayPage(
                  order: widget.order,
                  fee: _fee / 100,
                  // isStandart: widget.isStandstart,
                ));
          });
        } else {
          return _detailBottomButton('余额不足支付上链费，请先充值', topMargin: 40.px,
              onTap: () {
            AppNavigator.push(context, RechargePage());
          });
        }
      }
      switch (widget.order.status) {
        case OrderStateEnum.OS_Prepare: // 等待商户接单
          {
            return _detailBottomButton('等待商户接单', onTap: () {});
          }
        case OrderStateEnum.OS_IsPayed:
          {
            return _detailBottomButton('等待商户出票', onTap: () {});
          }
        case OrderStateEnum.OS_Cancel: // 商户已拒单
          {
            return _detailBottomButton('商户已拒单', onTap: () {});
          }
        case OrderStateEnum.OS_Taked: //商户接单后上传付款码,用户下载付款码到相册，并且扫码支付后点击此按钮(支付完成)
          {
            return _detailBottomButton('通知商户已支付', onTap: () {
              _changeOrderPayed();
            });
          }
        case OrderStateEnum.OS_Done: //商户出票后用户需确认
          {
            return _detailBottomButton('确认正确', onTap: () {
              _changeOrderConfirm();
            });
          }
        case OrderStateEnum.OS_UpChained: //上链成功
          {
            return _checkOrder();
          }
        case OrderStateEnum.OS_Confirm:
          {
            if (widget.order.loterryType! >= 1 &&
                widget.order.loterryType! <= 7) {
              return _confirmOrder();
            } else {
              return _detailBottomButton('核实完毕', onTap: () {});
            }
          }
        case OrderStateEnum.OS_Prizeed: //收到商户发起兑奖动作,用户上传收款码
          {
            if (widget.order.prize! > 0) {
              return _changeAcceptPrizeedImage();
            } else {
              return _finishedOrderNotPrized();
            }
          }
        case OrderStateEnum.OS_AcceptPrizeed: //商户完成兑奖转账
          {
            if (widget.order.prize! > 0) {
              return _finishedOrder();
            } else {
              return _finishedOrderNotPrized();
            }
          }
        default:
          return SizedBox();
      }
    }
  }

  Widget _detailBottomButton(String title,
      {double topMargin = 0, Function? onTap}) {
    return InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
          height: 64.px,
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: 40.px,
            decoration: BoxDecoration(
                color: Color(0XFFFF4400),
                borderRadius: BorderRadius.all(Radius.circular(4.px)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFFF4400),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.px,
                      spreadRadius: 0)
                ]),
            alignment: Alignment.center,
            child: CommonText(
              title,
              fontSize: 16.px,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _shopBottom() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '完成出票',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                _showMedia(action: 2); //商户上传拍照
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopTakeOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              borderColor: Colours.app_main,
              color: Colors.white,
              text: '拒绝接单',
              fontSize: 16.px,
              textColor: Colors.black,
              onTap: () {
                _changeOrderRefuse();
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '接单',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                if (widget.order.photos!.length == 0) {
                  _showMedia(action: 3);
                } else {
                  OrderMod.takeOrder(widget.order.orderID!).then((val) {
                    _changeTakeOrder();
                    HubView.showToastAfterLoadingHubDismiss('接单成功');
                  }).catchError((err) {
                    logE(err);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              borderColor: Colours.app_main,
              color: Colors.white,
              text: '查看区块链存证',
              fontSize: 16.px,
              textColor: Colors.black,
              onTap: () {
                AppNavigator.push(context, AntChainQrPage(qrurl: _qrcodeUrl));
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '确认存证真实',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                _changeOrderConfirm();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              borderColor: Colours.app_main,
              color: Colors.white,
              text: '查看区块链存证',
              fontSize: 16.px,
              textColor: Colors.black,
              onTap: () {
                AppNavigator.push(context, AntChainQrPage(qrurl: _qrcodeUrl));
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '核实完毕, 祝您中大奖',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _finishedOrder() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              borderColor: Colours.app_main,
              color: Colors.white,
              text: '查看区块链存证',
              fontSize: 16.px,
              textColor: Colors.black,
              onTap: () {
                AppNavigator.push(context, AntChainQrPage(qrurl: _qrcodeUrl));
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '商户已付款,兑奖结束',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                HubView.showToastAfterLoadingHubDismiss('此订单已结束');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _finishedOrderNotPrized() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              borderColor: Colours.app_main,
              color: Colors.white,
              text: '查看区块链存证',
              fontSize: 16.px,
              textColor: Colors.black,
              onTap: () {
                AppNavigator.push(context, AntChainQrPage(qrurl: _qrcodeUrl));
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '结束-未中奖',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

//用户中奖之后上传收款码
  Widget _changeAcceptPrizeedImage() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '上传收款码',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                _showMedia(action: 4);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _shopPrizeBottom() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '兑奖',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                AppNavigator.push(context, PrizePage()).then((value) {
                  // print(value);
                  logI('push PrizePage value: $value');
                  _uploadPrizeImageAndChange(
                      value['money']); //, value['imageLocalPath']
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadSelectNums() {
    // if (widget.order.lo)
    _selectedNums.clear();
    _selectedNums = LotteryUtils.loadSelectNums(widget.order);
    setState(() {});
  }

  void _loadImageIfDone() async {
    if (widget.order.status == null ||
        widget.order.status == OrderStateEnum.OS_Prepare) {
      WalletMod.getBalance().then((value) {
        _balance = value;
      }).catchError((e) {
        _balance = 0;
      });
    }
    if (widget.order.status == OrderStateEnum.OS_Refuse) {
      setState(() {});
      return;
    }
    if (widget.order.status != null) {
      if (widget.order.orderID == null || widget.order.orderID! == '') {
        logW('widget.order.orderID 为空');
        return;
      }
      OrderMod.getOrderPhotos(widget.order.orderID!).then((value) {
        //TODO
        if (value != null && value != '') {
          List<dynamic> _tmpList = json.decode(value);
          _tmpList.forEach((element) async {
            widget.order.photos!.add(element);
            String? _tempUrl = await appManager.getOrderImages(element);
            logI('_loadImageIfDone, _tempUrl:$_tempUrl');
            addTestData(_tempUrl!);
            setState(() {});
          });
        } else {
          logW('交互图片为空');
        }
      }).catchError((err) {
        logE(err);
      });
    }
    if (widget.order.status == OrderStateEnum.OS_UpChained ||
        widget.order.status == OrderStateEnum.OS_Confirm) {
      OrderMod.getAntChainQrcode(widget.order.orderID!).then((url) {
        if (url == '') {
          logW(' OrderMod.getAntChainQrcode 返回的是空url');
        } else {
          _qrcodeUrl = url;
        }
        logI('_qrcodeUrl: $_qrcodeUrl');
        setState(() {});
      }).catchError((err) {});
    }
  }

  ///根据总金额计算上链服务费
  ///传参total_amount是以分为单位
  void _calculateOrderPrice(double totalAmount) {
    OrderMod.getOrderFee(totalAmount).then((value) {
      setState(() {
        _fee = value['fee'] as int;
      });
    }).catchError((err) {
      logE(err);
    });
  }

  void _showMedia({int action = 1}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min, // 设置最小的弹出
            children: <Widget>[
              ListTile(
                title: Text("拍照"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _cameraAction(action);
                },
              ),
              ListTile(
                title: Text("相册"),
                onTap: () async {
                  Navigator.of(context).pop();
                  _photoAction(action);
                },
              ),
            ],
          ));
        });
  }

  void _cameraAction(int action) {
    CameraPicker.pickFromCamera(context, enableRecording: false)
        .then((value) async {
      AssetEntity asset = value!;
      File? file = await asset.file;
      _UploadImage(action, file!.path, asset.type);
    });
  }

  void _photoAction(int action) {
    AssetPicker.pickAssets(context,
            requestType: RequestType.image, maxAssets: 1)
        .then((assets) async {
      if (assets != null && assets.length > 0) {
        AssetEntity asset = assets.first;
        File? file = await asset.file;
        _UploadImage(action, file!.path, asset.type);
      }
    });
  }

  void _UploadImage(int action, String sourceFile, AssetType type) async {
    HubView.showLoading();
    switch (action) {
      case 1:
        String url = await UserMod.uploadOssOrderFile(sourceFile);
        if (url != '') {
          logD('uploadOssOrderFile 上传交互图片 完成, url: $url');

          if (widget.order.photos == null || widget.order.orderID == null) {
            logW('photos or orderID 为 null ');
            break;
          }
          widget.order.photos!.add(url);
          logI('add ok ');
          OrderMod.uploaOrderPhotos(widget.order.orderID!, widget.order.photos!)
              .then((value) {
            logI('uploaOrderPhotos  完成, value: $value');
          }).catchError((e) {
            logE(e);
          });
        } else {
          HubView.showToastAfterLoadingHubDismiss('上传交互图片出错');
        }
        break;
      case 2:
        String url = await UserMod.uploadOssOrderFile(sourceFile);
        if (url != '') {
          logD('uploadOssOrderFile 上传交互图片 完成, url: $url');

          if (widget.order.photos == null || widget.order.orderID == null) {
            logW('photos or orderID 为 null ');
            break;
          }
          widget.order.photos!.add(url);
          logI('add ok ');
          OrderMod.uploaOrderPhotos(widget.order.orderID!, widget.order.photos!)
              .then((value) {
            logI('uploaOrderPhotos  完成, value: $value');
            _changeOrderDone();
          }).catchError((e) {
            logE(e);
          });
        } else {
          HubView.showToastAfterLoadingHubDismiss('上传交互图片出错');
        }
        break;

      case 3:
        {
          OrderMod.takeOrder(widget.order.orderID!).then((val) {
            _changeTakeOrder();
            HubView.showToastAfterLoadingHubDismiss('接单成功');
          }).catchError((err) {
            logE(err);
          });
        }
        HubView.dismiss();
        break;

      case 4:
        {
          OrderMod.changeOrderStatus(widget.order.orderID!,
                  OrderStateEnum.OS_AcceptPrizeed, ProductOrderType.POT_Normal)
              .then((value) async {
            HubView.dismiss();
            HubView.showToastAfterLoadingHubDismiss('已上传兑奖收款码');
            setState(() {
              // widget.order.status = OrderStateEnum.OS_AcceptPrizeed;
            });
            NotificationCenter.instance
                .postNotification(NotificationDefine.orderUpdate);
          }).catchError((err) {
            HubView.showToastAfterLoadingHubDismiss(err);
          });
        }
        HubView.dismiss();
        break;

      default:
        break;
    }
    HubView.dismiss();
  }

  void _changeTakeOrder() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!, OrderStateEnum.OS_Taked,
            ProductOrderType.POT_Normal)
        .then((value) async {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已接单');
      setState(() {
        widget.order.status = OrderStateEnum.OS_Taked;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);

      HubView.dismiss();
    });
  }

  void _changeOrderDone() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!, OrderStateEnum.OS_Done,
            ProductOrderType.POT_Normal)
        .then((value) async {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已完成订单');
      setState(() {
        widget.order.status = OrderStateEnum.OS_Done;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderRefuse() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!, OrderStateEnum.OS_Refuse,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已拒绝订单');
      setState(() {
        widget.order.status = OrderStateEnum.OS_Refuse;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderConfirm() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!, OrderStateEnum.OS_Confirm,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.showToastAfterLoadingHubDismiss('已确认订单');
        setState(() {
          widget.order.status = OrderStateEnum.OS_Confirm;
        });
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      } else {
        HubView.showToastAfterLoadingHubDismiss('操作异常');
      }
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderAcceptPrizeed() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!,
            OrderStateEnum.OS_AcceptPrizeed, ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('已通知用户');
        setState(() {
          widget.order.status = OrderStateEnum.OS_AcceptPrizeed;
        });
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      } else {
        HubView.showToastAfterLoadingHubDismiss('操作异常');
      }
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderPayed() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(widget.order.orderID!, OrderStateEnum.OS_IsPayed,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.dismiss();
        HubView.showToastAfterLoadingHubDismiss('已通知商户');
        setState(() {
          widget.order.status = OrderStateEnum.OS_IsPayed;
        });
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      } else {
        HubView.showToastAfterLoadingHubDismiss('操作异常');
      }
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _uploadPrizeImageAndChange(String money) {
    logI('_uploadPrizeImageAndChange, money: $money');
    OrderMod.inputPrize(widget.order.orderID!, double.parse(money))
        .then((value) {
      HubView.showToastAfterLoadingHubDismiss('设置兑奖金额成功');
      _reloadOrder();
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    });
  }

  void _reloadOrder() {
    OrderMod.getOrder(widget.order.orderID!).then((value) async {
      List<OrderModel> list =
          await OrderModel.modelListFromServerDatas([value]);

      setState(() {
        widget.order = list.first;
      });
      logI('_reloadOrder: order: ${widget.order.toJson()}');
      _fee = value.fee; //订单会返回服务费，以分为单位
      _prize = value.prize; //中奖金额，以分为单位
      logI('中奖金额，以分为单位: _prize: ${_prize}， order.prize: ${widget.order.prize}');
      _loadSelectNums();
      _loadImageIfDone();
    }).catchError((err) {});
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfo) {
    if (orderInfo.orderId == widget.order.orderID) {
      _reloadOrder();
    }
  }
}
