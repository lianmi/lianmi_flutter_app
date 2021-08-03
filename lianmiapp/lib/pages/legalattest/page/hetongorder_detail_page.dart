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
import 'package:lianmiapp/pages/legalattest/page/hetongorder_pay_page.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/page/antchain_qr_page.dart';
// import 'package:lianmiapp/pages/product/page/lottery_pay_page.dart';K
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

  String? _cunzhengUrl; //表示接单后的司法链的存证证明图片
  String? _qrcodeUrl;

  ///图片类型
  int _imageType = 0;

  int _balance = 0;

  @override
  void initState() {
    super.initState();

    LinkMeManager.instance.addOrderListener(this);
    order = widget.order;

    _loadImageIfDone(); //加载拍照图片
  }

  @override
  Widget build(BuildContext context) {
    ProductModel? product = LotteryData.instance.getProduct(order.loterryType!);
    // int count = order.count!;
    // int multiple = order.multiple!;
    int price = product!.productPrice!; //以分为单位

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
              // OrderDetailListWidget(_selectedNums),
              Gaps.vGap20,
              _commonItem('商户名称', '${widget.order.shopName}'),
              _commonItem('详细说明', '${product.productName}'),
              _commonItem('总价', '${price / 100}元'), //已元为单位
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
        order.status == OrderStateEnum.OS_UpChained) {
      return Container(
        width: double.infinity,
        height: 50.px,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CommonButton(
                text: '存证图片1',
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
                text: '存证图片2',
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
              '下单后,商户如果接单，将会发送付款码给买家，买家扫码支付后才出证',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xAA001133),
              ),
            )
          ],
        ),
      );

    String? _imgUrl;

    if (_imageType == 0) {
      _imgUrl = _cunzhengUrl;
    }
    if (_imgUrl != null) {
      if (_imgUrl.contains('https') == false) {
        String prefix = 'https://lianmi-ipfs.oss-cn-hangzhou.aliyuncs.com/';
        _imgUrl = prefix + _imgUrl;
      }
    } else {
      _imgUrl = ImageStandard.logo;
    }
    logD('_imgUrl: ${_imgUrl}');

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
                  context, [_imgUrl!], 0);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.px)),
              child: Container(
                width: double.infinity,
                child: LoadImageWithHolder(
                  _imgUrl,
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
                // _changeOrderConfirm();
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
      setState(() {});
    }
    if (order.status == OrderStateEnum.OS_Done ||
        order.status == OrderStateEnum.OS_Confirm ||
        order.status == OrderStateEnum.OS_UpChained) {
      HubView.showLoading();
      HttpUtils.get(HttpApi.orderimage + order.orderID!).then((val) {
        HubView.dismiss();
        _cunzhengUrl = val;
        setState(() {});
      }).catchError((err) {
        HubView.dismiss();
      });
    }

    if (order.status == OrderStateEnum.OS_UpChained) {
      OrderMod.getAntChainQrcode(order.orderID!).then((url) {
        if (url == '') {
        } else {
          _qrcodeUrl = url;
        }
        // logI('_qrcodeUrl: $_qrcodeUrl');
        setState(() {});
      }).catchError((err) {});
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
            UserMod.uploadOssOrderFile(value, (String url) {
              HubView.dismiss();
              logD('上传拍照图片成功:$url');
              _cunzhengUrl = url;
              _uploadorderimage(hash);
            }, (String errMsg) {
              HubView.dismiss();
              logD('上传附件错误:$errMsg');
              HubView.showToastAfterLoadingHubDismiss(errMsg);
            }, (int progress) {
              logD('上传附件进度:$progress');
            });
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
      'image': _cunzhengUrl,
      'image_hash': hash,
    };
    HttpUtils.post(HttpApi.uploadorderimage, data: _map).then((val) {
      HubView.dismiss();
      _changeOrderDone();
    }).catchError((err) {
      HubView.dismiss();
    });
  }

  void _uploadCollectMoneyImage(String sourceImageFile) {
    HubView.showLoading();
    OrderMod.takeOrder(order.orderID!, sourceImageFile).then((val) {
      HubView.dismiss();
      _changeTakeOrder();
      if (val) {}
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
      // _prize = value.prize; //中奖金额，以分为单位
      // logI('中奖金额，以分为单位: _prize: ${_prize}， order.prize: ${order.prize}');
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
