import 'dart:io';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
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
import 'package:lianmiapp/pages/common/gallery_photo_view_wrapper.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'antchain_qr_page.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel order;

  OrderDetailPage(this.order);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with QrEvents
    implements LinkMeManagerOrderStatusListerner {
  late OrderModel order;

  List _selectedNums = [];

  int _fee = 0; //以分为单位
  int _prize = 0; //中奖金额 以分为单位

  String? _lotteryUrl;
  // String? _imgUrl;

  String _qrcodeUrl = '';

  ///图片类型 0未开奖图片  1开奖图片
  int _imageType = 0;

  int _payMode = 0;

  int _balance = 0;

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
    order = widget.order;

    _loadSelectNums();

    _loadImageIfDone(); //加载拍照图片
  }

  @override
  Widget build(BuildContext context) {
    ProductModel? product = LotteryData.instance.getProduct(order.loterryType!);
    int count = order.count!;
    int multiple = order.multiple!;
    int price = product!.productPrice! * count * multiple; //总价

    //首次必须计算上链服务费
    if (_fee == 0) {
      _calculateOrderPrice(price);
    }
    String totalPrice = '';

    if (App.isShop) {
      totalPrice = (price / 100).toStringAsFixed(2); //商户不需要合计上链服务费
    } else {
      totalPrice = (_fee / 100 + price / 100).toStringAsFixed(2); //合计
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
              _descWidget(),
              OrderDetailListWidget(_selectedNums),
              Gaps.vGap20,
              _commonItem('商户名称', '${widget.order.shopName}'),
              _commonItem(
                  '详细说明',
                  (widget.order.loterryType! <= 7)
                      ? '${product.productName} ${count}注${multiple}倍'
                      : '${product.productName}'),
              _commonItem('总价', '${price / 100}元'),
              _feeWidget(_fee),
              // _memberItem(),
              // Gaps.vGap20,
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

  // Widget _memberItem() {
  //   return SizedBox();
  //   if (AppManager.isVip) return SizedBox();
  //   return Container(
  //     padding: EdgeInsets.only(left: 30.px, right: 30.px),
  //     width: double.infinity,
  //     height: 48.px,
  //     color: Color(0XFFFECD78),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Image.asset(
  //               ImageStandard.logo,
  //               width: 20.px,
  //               height: 20.px,
  //             ),
  //             Gaps.hGap10,
  //             CommonText(
  //               '会员服务费立减',
  //               fontSize: 16.px,
  //             )
  //           ],
  //         ),
  //         CommonText(
  //           '开通会员',
  //           fontSize: 16.px,
  //         )
  //       ],
  //     ),
  //   );
  // }

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
                text: '信息',
                fontSize: 16.px,
                color: Colors.white,
                textColor: _imageType == 0 ? Colours.app_main : Colors.black,
                onTap: () {
                  setState(() {
                    _imageType = 0;
                  });
                },
              ),
            ),
            Expanded(
              child: CommonButton(
                text: '兑奖信息',
                fontSize: 16.px,
                color: Colors.white,
                textColor: _imageType == 1 ? Colours.app_main : Colors.black,
                onTap: () {
                  setState(() {
                    _imageType = 1;
                  });
                },
              ),
            )
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
              '下单后,商户如果接单，将会发送付款码给买家，买家扫码支付后才出票',
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
              GalleryPhotoViewWrapperUtils.navigateToPhotoAblums(
                  context, [_lotteryUrl!], 0);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.px)),
              child: Container(
                width: double.infinity,
                child: LoadImageWithHolder(
                  _lotteryUrl == null ? 'assets/images/none.png' : _lotteryUrl,
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
            return _shopPrizeBottom();
          }
        case OrderStateEnum.OS_Confirm:
          {
            return _shopPrizeBottom();
          }
        case OrderStateEnum.OS_Prizeed: //商户发起兑奖动作,通知用户上传收款码
          {
            if (order.prize! > 0) {
              return _detailBottomButton('等待用户发起收款', onTap: () {});
            } else {
              return _detailBottomButton('未中奖', onTap: () {});
            }
          }

        case OrderStateEnum.OS_AcceptPrizeed: //商户收到用户上传的收款码
          {
            if (order.prize! > 0) {
              return _detailBottomButton('完成兑奖付款', onTap: () {
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
      if (order.status == null) {
        if (_balance >= _fee) {
          return _detailBottomButton('立即下单', topMargin: 40.px, onTap: () {
            AppNavigator.push(
                context, LotteryPayPage(order: order, fee: _fee / 100));
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
            if (order.loterryType! >= 1 && order.loterryType! <= 7) {
              return _confirmOrder();
            } else {
              return _detailBottomButton('核实完毕', onTap: () {});
            }
          }
        case OrderStateEnum.OS_Prizeed: //收到商户发起兑奖动作,用户上传收款码
          {
            if (order.prize! > 0) {
              return _changeAcceptPrizeedImage();
            } else {
              return _finishedOrderNotPrized();
            }
          }
        case OrderStateEnum.OS_AcceptPrizeed: //商户完成兑奖转账
          {
            if (order.prize! > 0) {
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
          // Expanded(
          //   child: CommonButton(
          //     width: double.infinity,
          //     height: double.infinity,
          //     borderRadius: 4.px,
          //     borderColor: Colours.app_main,
          //     color: Colors.white,
          //     text: '拒绝接单',
          //     fontSize: 16.px,
          //     textColor: Colors.black,
          //     onTap: () {
          //       _changeOrderRefuse();
          //     },
          //   ),
          // ),
          // SizedBox(width: 14.px),
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
              onTap: () {
                // _changeOrderConfirm();
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
              text: '兑奖结束',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                // _changeOrderConfirm();
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

//上传我的收款码
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
              text: '上传我的收款码',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                _showMedia(action: 3); //用户上传兑奖收款码
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
                      value['money'], value['imageLocalPath']);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadSelectNums() {
    _selectedNums.clear();
    _selectedNums = LotteryUtils.loadSelectNums(order);
    setState(() {});
  }

  void _loadImageIfDone() async {
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
      HubView.showLoading();

      //获取商家的收款码
      OrderMod.getPayUrl(order.orderID!).then((url) async {
        HubView.dismiss();
        if (url == '') {
          // logW('无法获取商家的收款码');
          _lotteryUrl = ImageStandard.logo;
        } else {
          if (_imageType == 0) {
            _lotteryUrl = await appManager.getOrderImages(
              url,
              storeUserName: order.businessUsername,
            );
          } else {
            _lotteryUrl = await appManager.getOrderImages(order.prizedPhoto!,
                storeUserName: order.businessUsername);
          }
          logD('_lotteryUrl: ${_lotteryUrl}');
          if (_lotteryUrl == null) {
            _lotteryUrl = ImageStandard.logo;
          }

          if (_lotteryUrl != '') logI('获取商家的收款码 _lotteryUrl: $_lotteryUrl');
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
        _lotteryUrl = await appManager.getOrderImages(val,
            storeUserName: order.businessUsername);
        setState(() {});
      }).catchError((err) {
        HubView.dismiss();
      });
    }

    if (order.status == OrderStateEnum.OS_UpChained ||
        order.status == OrderStateEnum.OS_Confirm ||
        order.status == OrderStateEnum.OS_Prizeed ||
        order.status == OrderStateEnum.OS_AcceptPrizeed) {
      OrderMod.getAntChainQrcode(order.orderID!).then((url) {
        if (url == '') {
        } else {
          _qrcodeUrl = url;
        }
        // logI('_qrcodeUrl: $_qrcodeUrl');
        setState(() {});
      }).catchError((err) {});
      OrderMod.getPrizeUrl(order.orderID!).then((url) async {
        // HubView.dismiss();
        if (url == '') {
        } else {
          _lotteryUrl = await appManager.getOrderImages(url,
              storeUserName: order.businessUsername);
        }
        logI('_lotteryUrl: $_lotteryUrl');
        setState(() {});
      }).catchError((err) {
        // HubView.dismiss();
      });
    }
  }

//根据总金额计算上链服务费
  void _calculateOrderPrice(int totalAmount) {
    HubView.showLoading();
    //传参total_amount是以分为单位
    HttpUtils.post(HttpApi.calculateOrderFee,
        data: {'total_amount': totalAmount}).then((val) {
      HubView.dismiss();
      setState(() {
        _fee = val['fee'] as int;
        // _fee_rate = val['fee_rate'];
        // _rate_free_amount = val['rate_free_amount'].toDouble();
      });
    }).catchError((err) {
      HubView.dismiss();
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
        {
          //上传收款码
          //TODO需要加密
          HubView.showLoading();
          OrderMod.takeOrder(order.orderID!, sourceFile).then((val) {
            HubView.dismiss();
            _changeTakeOrder();
            if (val) {}
          }).catchError((err) {
            HubView.dismiss();
          });
        }
        break;

      case 2:
        {
          String hash = await OrderMod.getHash256(sourceFile);
          //TODO需要加密
          if (App.isShop) {
            OrderMod.encryptAndUploadFile(sourceFile).then((url) async {
              HubView.dismiss();
              logD('上传加密拍照图片成功:$url');
              _lotteryUrl = await appManager.getOrderImages(url,
                  storeUserName: order.businessUsername);
              _uploadorderimage(hash, url);
            }).catchError((e) {
              HubView.dismiss();
              HubView.showToastAfterLoadingHubDismiss('上传加密拍照图片错误');
              logE(e);
            });
          } else {
            OrderMod.encryptAndUploadFile(sourceFile,
                    storeUserName: order.businessUsername)
                .then((url) async {
              HubView.dismiss();
              logD('上传加密拍照图片成功:$url');
              _lotteryUrl = await appManager.getOrderImages(url,
                  storeUserName: order.businessUsername);
              _uploadorderimage(hash, url);
            }).catchError((e) {
              HubView.dismiss();
              HubView.showToastAfterLoadingHubDismiss('上传加密拍照图片错误');
              logE(e);
            });
          }
        }
        break;
      case 3:
        {
          //上传兑奖收款码
          //TODO需要加密
          OrderMod.acceptPrize(
                  order.orderID!, order.businessUsername!, sourceFile)
              .then((value) {
            if (value) {
              OrderMod.changeOrderStatus(
                      order.orderID!,
                      OrderStateEnum.OS_AcceptPrizeed,
                      ProductOrderType.POT_Normal)
                  .then((value) async {
                HubView.dismiss();
                HubView.showToastAfterLoadingHubDismiss('已上传兑奖收款码');
                setState(() {
                  order.status = OrderStateEnum.OS_AcceptPrizeed;
                });
                NotificationCenter.instance
                    .postNotification(NotificationDefine.orderUpdate);
              }).catchError((err) {
                HubView.showToastAfterLoadingHubDismiss(err);
              });
            }
          });
        }
        break;
      default:
        break;
    }
  }

  void _uploadorderimage(String hash, String url) async {
    HubView.showLoading();
    var _map = {
      'order_id': order.orderID,
      'image': url,
      'image_hash': hash,
    };
    HttpUtils.post(HttpApi.uploadorderimage, data: _map).then((val) {
      HubView.dismiss();
      _changeOrderDone();
    }).catchError((err) {
      HubView.dismiss();
    });
  }

  void _changeTakeOrder() {
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

      // await OrderMod.encryptOrderBodyToAliyunOSS(widget.order.orderID!, widget.order.toAttach());
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

  void _changeOrderAcceptPrizeed() {
    HubView.showLoading();
    OrderMod.changeOrderStatus(order.orderID!, OrderStateEnum.OS_AcceptPrizeed,
            ProductOrderType.POT_Normal)
        .then((value) {
      HubView.dismiss();
      if (value == true) {
        HubView.showToastAfterLoadingHubDismiss('已通知用户');
        setState(() {
          order.status = OrderStateEnum.OS_AcceptPrizeed;
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

  void _uploadPrizeImageAndChange(String money, String imageLocalPath) {
    HubView.showLoading();
    UserMod.uploadOssOrderFile(imageLocalPath, (String url) {
      HubView.dismiss();
      logI('上传兑奖二维码图片成功:money: $money, url;$url');
      OrderMod.inputPrize(widget.order.orderID!, url, double.parse(money))
          .then((value) {
        HubView.showToastAfterLoadingHubDismiss('成功上传兑奖二维码图片成功');
        _reloadOrder();
        NotificationCenter.instance
            .postNotification(NotificationDefine.orderUpdate);
      });
    }, (String errMsg) {
      HubView.dismiss();
      logD('上传兑奖二维码图片成功错误:$errMsg');
      HubView.showToastAfterLoadingHubDismiss(errMsg);
    }, (int progress) {
      logD('上传兑奖二维码图片成功进度:$progress');
    });
  }

  void _reloadOrder() {
    OrderMod.getOrder(widget.order.orderID!).then((value) async {
      List<OrderModel> list =
          await OrderModel.modelListFromServerDatas([value]);

      setState(() {
        order = list.first;
      });
      logI('_reloadOrder: order: ${order.toJson()}');
      _fee = value.fee; //订单会返回服务费，以分为单位
      _prize = value.prize; //中奖金额，以分为单位
      logI('中奖金额，以分为单位: _prize: ${_prize}， order.prize: ${order.prize}');
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