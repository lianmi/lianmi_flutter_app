import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/legalattest/page/BrowserNineGridViewPage.dart';
import 'package:lianmiapp/pages/legalattest/page/change_cost_page.dart';
import 'package:lianmiapp/pages/legalattest/page/hetongorder_pay_page.dart';
import 'package:lianmiapp/pages/legalattest/provider/hetong_provider.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/antchain_qr_page.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/pages/me/events/qr_events.dart';
import 'package:lianmiapp/pages/me/page/recharge_page.dart';
import 'package:lianmiapp/pages/order/widgets/order_detail_status_widget.dart';
import 'package:lianmiapp/pages/common/gallery_photo_view_wrapper.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class HetongOrderDetailPage extends StatefulWidget {
  final OrderModel order;

  HetongOrderDetailPage(this.order);

  @override
  _HetongOrderDetailPageState createState() => _HetongOrderDetailPageState();
}

class _HetongOrderDetailPageState extends State<HetongOrderDetailPage>
    with QrEvents
    implements LinkMeManagerOrderStatusListerner {
  GlobalKey _globalKey = GlobalKey();

  late OrderModel order;

  int _fee = 0; //以分为单位

  String? _payUrl; //交互图片
  String? _qrcodeUrl;

  ///图片类型
  // int _imageType = 0;

  int _balance = 0;

  @override
  void initState() {
    super.initState();

    LinkMeManager.instance.addOrderListener(this);
    order = widget.order; //接外部的order

    // _loadAttachs(); //加载附件
    order.cunzhengModelData!.attachs.forEach((url) {
      logI('initState, url: ' + url);
    });

    _loadImageIfDone(); //加载拍照图片
  }

  @override
  Widget build(BuildContext context) {
    ProductModel? product = LotteryData.instance.getProduct(order.loterryType!);

    int price = product!.productPrice!; //以分为单位

    int _urlCount = order.cunzhengModelData!.attachs.length;
    logI('initState, _urlCount: $_urlCount');

    //首次必须计算上链服务费
    if (_fee == 0) {
      _calculateOrderPrice(order.cost!);
    }
    String totalPrice = '';

    if (App.isShop) {
      totalPrice = order.cost!.toStringAsFixed(1); //商户不需要合计上链服务费
    } else {
      totalPrice = (_fee / 100 + order.cost!).toStringAsFixed(1); //合计
    }

    String payModeStr = '';
    if (order.payMode == 1) {
      payModeStr = '微信';
    } else {
      payModeStr = '支付宝';
    }

    // logD('status: ${order.status}');

    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '订单详情',
        ),
        backgroundColor: Color(0XEEEEEEEE),
        body: SafeArea(
            child: Container(
          child: ListView(
            children: [
              _ticketCodeItem(),
              // _descWidget(),
              // OrderDetailListWidget(_selectedNums),
              Gaps.vGap20,
              _commonItem('商户名称', '${widget.order.shopName}'),
              _commonItem('说明', '${order.cunzhengModelData!.description}'),
              _commonItem('姓名', '${order.cunzhengModelData!.jiafangName}'),
              _commonItem('手机', '${order.cunzhengModelData!.jiafangPhone}'),
              _changePriceItem('总价', '${order.cost!}元'), //元为单位
              _attachsItem('附件', '总数${_urlCount}个  >'),
              _feeWidget(_fee),
              _commonItem('合计', '${totalPrice}元'),
              _commonItem('支付方式', '${payModeStr}'),

              _orderIDWidget(),
              _orderTimeArea(),
              _imageArea(), //根据订单状态显示不同的图片
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

//商户简介
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

  Widget _attachsItem(String title, String desc, {EdgeInsetsGeometry? margin}) {
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
          InkWell(
            onTap: () {
              if (widget.order.status != null) {
                AppNavigator.push(
                        context, new BrowserNineGridViewPage(this.order))
                    .then((value) {
                  if (value != null) {
                    logI("Back Params value: ${value['attachList']}");
                  }
                });
              }
            },
            child: Container(
              height: 48.px,
              margin: margin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        desc,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xAA001133),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _changePriceItem(String title, String desc,
      {EdgeInsetsGeometry? margin}) {
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
          InkWell(
            onTap: () {
              if (App.isShop) {
                logI('商户修改价格');
                AppNavigator.push(context, ChangeCostPage(this.order))
                    .then((value) {
                  if (value != null) {
                    logI("Back Params value: ${value}");
                    //TODO: 向服务端提交商户更改价格，并推送给用户，刷新订单
                    OrderMod.changeOrderCost(
                            this.order.orderID!, double.parse(value['cost']))
                        .then((value) {
                      setState(() {});
                    }).catchError((e) {
                      logE(e);
                    });
                  }
                });
              }
            },
            child: Container(
              height: 48.px,
              margin: margin, //EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        App.isShop ? '$desc, 修改价格>' : '$desc',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xAA001133),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
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
    if (order.orderID == null) return SizedBox();
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

  Widget _imageTabArea() {
    if (order.status == OrderStateEnum.OS_Done ||
        order.status == OrderStateEnum.OS_Confirm ||
        order.status == OrderStateEnum.OS_UpChained ||
        order.status == OrderStateEnum.OS_Prizeed ||
        order.status == OrderStateEnum.OS_AcceptPrizeed) {
      return Container(
        width: double.infinity,
        height: 50.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CommonButton(
                text: '交互图片区',
                fontSize: 16.px,
                color: Colors.white,
                textColor: Colours.app_main,
                onTap: () {
                  setState(() {
                    // _imageType = 0;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else if (order.status == OrderStateEnum.OS_Taked) {
      return Container(
        width: double.infinity,
        height: 50.px,
        alignment: Alignment.centerLeft,
        child: CommonText(
          '收款码',
          fontSize: 16.px,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  //图片显示区
  Widget _imageArea() {
    if (order.status == OrderStateEnum.OS_Refuse) {
      return SizedBox();
    }
    if (order.status == null || order.status == OrderStateEnum.OS_Prepare)
      return Container(
        margin: EdgeInsets.only(top: 20.px),
        padding: EdgeInsets.fromLTRB(23.px, 0, 23.px, 16.px),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 6,
              ),
            ),
            Text(
              '下单后,商户如果接单，将会发送付款码给买家，买家扫码支付后才出证',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xAA001133),
              ),
            )
          ],
        ),
      );

    return Container(
      margin: EdgeInsets.only(top: 20.px),
      padding: EdgeInsets.fromLTRB(23.px, 0, 23.px, 16.px),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          _imageTabArea(),
          InkWell(
            onTap: () {
              if (_payUrl != null) {
                GalleryPhotoViewWrapperUtils.navigateToPhotoAblums(
                    context, [_payUrl!], 0);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.px)),
              child: Container(
                width: double.infinity,
                child: LoadImageWithHolder(
                  _payUrl == null ? 'assets/images/none.png' : _payUrl,
                  holderImg: ImageStandard.logo,
                  width: double.infinity,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _statusArea() {
    return OrderDetailStatusWidget(
        loterryType: order.loterryType ?? 0,
        status: order.status ?? OrderStateEnum.OS_Undefined,
        prize: order.prize ?? 0);
  }

  Widget _bottomArea() {
    if (App.isShop) {
      switch (order.status) {
        case OrderStateEnum.OS_Prepare:
          {
            return _shopTakeOrder();
          }
        case OrderStateEnum.OS_Taked:
          {
            return _detailBottomButton('收付款码已经发出，请留意查收', onTap: () {});
          }
        case OrderStateEnum.OS_IsPayed:
          {
            return _shopBottom();
          }
        case OrderStateEnum.OS_UpChained: //上链成功
          {
            return _detailBottomButton('上链成功', onTap: () {});
          }
        case OrderStateEnum.OS_Confirm:
          {
            return _detailBottomButton('对方已经确认存证正确', onTap: () {});
          }

        default:
          return SizedBox();
      }
    } else {
      if (order.status == null) {
        if (_balance >= _fee) {
          return _detailBottomButton('提交订单', topMargin: 40.px, onTap: () {
            //TODO 上传附件
            _uploadAttachs();

            AppNavigator.push(
                context, OrderPayPage(order: order, fee: _fee / 100));
          });
        } else {
          return _detailBottomButton('余额不足支付上链费，请先充值', topMargin: 40.px,
              onTap: () {
            AppNavigator.push(context, RechargePage());
          });
        }
      }
      switch (order.status) {
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
            return _detailBottomButton('我已经扫码支付', onTap: () {
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
            // return _detailBottomButton('核实完毕, 祝您生活愉快工作顺利', onTap: () {});
            return _finishedOrder();
          }

        default:
          return SizedBox();
      }
    }
  }

  //TODO 上传附件
  _uploadAttachs() async {
    if (order.cunzhengModelData!.attachsAliyun == null) {
      order.cunzhengModelData!.attachsAliyun = [];
    }
    order.cunzhengModelData!.attachs.forEach((filename) async {
      logI('准备上传附件: $filename');
      String url = await UserMod.uploadOssOrderFile(filename);
      if (url != '') {
        logI('上传附件成功, url: $url');

        order.cunzhengModelData!.attachsAliyun!.add(url);
      } else {
        logI('上传附件出错: $filename');
      }
    });
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
              text: '上传拍照',
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
              text: '接单并上传收款码',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                _showMedia(action: 1); //商户上传收款码
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
                AppNavigator.push(context, AntChainQrPage(qrurl: _qrcodeUrl!));
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
                if (_qrcodeUrl != null)
                  AppNavigator.push(
                      context, AntChainQrPage(qrurl: _qrcodeUrl!));
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
              text: '业务已全部结束',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                // 将provider重新初始化
                Provider.of<HetongProvider>(App.context!, listen: false)
                    .reset();
                //将九宫格初始化
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadImageIfDone() {
    if (order.status == null || order.status == OrderStateEnum.OS_Prepare) {
      WalletMod.getBalance().then((value) {
        _balance = value;
      }).catchError((e) {
        _balance = 0;
      });
    }
    if (order.status == OrderStateEnum.OS_Refuse) {
      setState(() {});
      return;
    }
    if (order.status == OrderStateEnum.OS_Prepare ||
        order.status == OrderStateEnum.OS_Taked ||
        order.status == OrderStateEnum.OS_IsPayed) {
      // HubView.showLoading();
      //获取商家的收款码
      OrderMod.getPayUrl(order.orderID!).then((url) async {
        HubView.dismiss();
        if (url == '') {
          // logW('无法获取商家的收款码');
          _payUrl = ImageStandard.logo;
        } else {
          _payUrl = await appManager.getOrderImages(
            url,
            storeUserName: order.businessUsername,
          );

          logI('获取商家的收款码 _payUrl: ${_payUrl}');
          if (_payUrl == null) {
            _payUrl = ImageStandard.logo;
          }
        }
        setState(() {});
      }).catchError((err) {
        HubView.dismiss();
      });
    }
    if (order.status == OrderStateEnum.OS_Done ||
        order.status == OrderStateEnum.OS_Confirm ||
        order.status == OrderStateEnum.OS_UpChained) {
      HubView.showLoading();
      HttpUtils.get(HttpApi.orderimage + order.orderID!).then((val) async {
        HubView.dismiss();
        logI('orderimage: $val');
        String? _tempUrl = await appManager.getOrderImages(val,
            storeUserName: order.businessUsername);
        if (_tempUrl != null && _tempUrl != '') {
          _payUrl = _tempUrl;
          logI('_payUrl: $_payUrl');
        }
        setState(() {});
      }).catchError((err) {
        HubView.dismiss();
      });
      OrderMod.getAntChainQrcode(order.orderID!).then((url) {
        if (url == '') {
          logW(' OrderMod.getAntChainQrcode 返回的是空url');
        } else {
          _qrcodeUrl = url;
        }
        logI('_qrcodeUrl: $_qrcodeUrl');
        setState(() {});
      }).catchError((err) {});
      HubView.dismiss();
    }
  }

  ///根据总金额计算上链服务费
  ///传参total_amount是以分为单位
  void _calculateOrderPrice(double totalAmount) {
    logI('_calculateOrderPrice, totalAmount: $totalAmount');

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
      _copyFileAndUpload(action, file!.path, asset.type);
    });
  }

  void _photoAction(int action) {
    AssetPicker.pickAssets(context,
            requestType: RequestType.image, maxAssets: 1)
        .then((assets) async {
      if (assets != null && assets.length > 0) {
        AssetEntity asset = assets.first;
        File? file = await asset.file;
        _copyFileAndUpload(action, file!.path, asset.type);
      }
    });
  }

  void _copyFileAndUpload(int action, String sourceFile, AssetType type) {
    FileManager.instance.copyFileToAppFolder(sourceFile).then((value) async {
      HubView.showLoading();
      switch (action) {
        case 1:
          {
            _uploadCollectMoneyImage(sourceFile); //上传收款码
          }
          break;

        case 2:
          {
            String hash = await OrderMod.getHash256(value);

            String url = await UserMod.uploadOssOrderFile(value);
            if (url != '') {
              HubView.dismiss();
              logD('上传拍照图片成功:$url');
              _payUrl = url;
              _uploadorderimage(hash); //上报
            } else {
              HubView.dismiss();
              logD('上传附件错误');
              HubView.showToastAfterLoadingHubDismiss('上传附件错误');
            }
          }
          break;

        default:
          break;
      }
    });
  }

  void _uploadorderimage(String hash) async {
    HubView.showLoading();
    var _map = {
      'order_id': order.orderID,
      'image': _payUrl,
      'image_hash': hash,
    };
    HttpUtils.post(HttpApi.uploadorderimage, data: _map).then((val) {
      HubView.dismiss();
      _changeOrderDone();
    }).catchError((err) {
      HubView.dismiss();
    });
  }

  void _uploadCollectMoneyImage(String sourceImageFile) async {
    if (order.orderID == null) return;
    HubView.showLoading();

    String url = await UserMod.uploadOssOrderFile(sourceImageFile);
    if (url != '') {
      logI('上传收款码成功, url: $url');
      HubView.showToastAfterLoadingHubDismiss('上传收款码成功');
      OrderMod.takeOrder(order.orderID!, url).then((val) {
        HubView.dismiss();
        _changeTakeOrder();
        if (val) {}
      }).catchError((err) {
        HubView.dismiss();
      });
    } else {
      HubView.dismiss();
      logI('上传附件出错: $sourceImageFile');
      HubView.showToastAfterLoadingHubDismiss('上传收款码出错');
    }
  }

  void _changeTakeOrder() {
    if (order.orderID == null) return;
    HubView.showLoading();
    OrderMod.changeOrderStatus(order.orderID!, OrderStateEnum.OS_Taked,
            ProductOrderType.POT_Normal)
        .then((value) async {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已接单');
      setState(() {
        order.status = OrderStateEnum.OS_Taked;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderDone() {
    if (order.orderID == null) return;
    HubView.showLoading();
    OrderMod.changeOrderStatus(
            order.orderID!, OrderStateEnum.OS_Done, ProductOrderType.POT_Normal)
        .then((value) async {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已完成订单');
      setState(() {
        order.status = OrderStateEnum.OS_Done;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderRefuse() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(order.orderID!, OrderStateEnum.OS_Refuse,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('已拒绝订单');
      setState(() {
        order.status = OrderStateEnum.OS_Refuse;
      });
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderConfirm() {
    if (order.orderID == null) return;
    HubView.showLoading();
    OrderMod.changeOrderStatus(order.orderID!, OrderStateEnum.OS_Confirm,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.showToastAfterLoadingHubDismiss('已确认订单');
        setState(() {
          order.status = OrderStateEnum.OS_Confirm;
        });
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      } else {
        HubView.showToastAfterLoadingHubDismiss('操作异常');
      }
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _changeOrderPayed() {
    HubView.showLoading();
    if (order.orderID == null) return;
    OrderMod.changeOrderStatus(order.orderID!, OrderStateEnum.OS_IsPayed,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.showToastAfterLoadingHubDismiss('已通知商户');
        setState(() {
          order.status = OrderStateEnum.OS_IsPayed;
        });
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      } else {
        HubView.showToastAfterLoadingHubDismiss('操作异常');
      }
    }).catchError((err) {
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }

  void _reloadOrder() {
    if (order.orderID == null) return;
    OrderMod.getOrder(widget.order.orderID!).then((value) async {
      List<OrderModel> list =
          await OrderModel.modelListFromServerDatas([value]);

      setState(() {
        order = list.first;
      });
      logI('_reloadOrder: order: ${order.toJson()}');
      _fee = value.fee; //订单会返回服务费，以分为单位
      _loadImageIfDone();
    }).catchError((err) {});
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfo) {
    if (orderInfo.orderId == widget.order.orderID) {
      _reloadOrder();
    }
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    logD(info);
    // _toastInfo(info);
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData?>);
    if (byteData != null) {
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      logD(result);
      // _toastInfo(result.toString());
    }
  }

  _getHttp() async {
    var response = await Dio().get(
        "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    logD(result);
    // _toastInfo("$result");
  }

  _saveGif() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.gif";
    String fileUrl =
        "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif";
    await Dio().download(fileUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    logD(result);
    // _toastInfo("$result");
  }

  _saveVideo() async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    String fileUrl =
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
    await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
      print((count / total * 100).toStringAsFixed(0) + "%");
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    logD(result);
    // _toastInfo("$result");
  }
}
