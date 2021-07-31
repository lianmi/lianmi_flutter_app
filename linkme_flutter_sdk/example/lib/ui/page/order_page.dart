import 'package:image_picker/image_picker.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import '../../application.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("order", 80, false).build(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _oneColumnWidget(),
            // _twoColumnWidget(),
          ],
        ),
      ),
    );
  }

  Widget _oneColumnWidget() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            _customButton('预下单', onTap: () async {
              try {
                var f = OrderMod.preOrder(
                    'id3', 'f44264da-b070-4f4e-b1c8-7e1eb07008a4', 2, 'body',
                    payMode: 1);
                f.then((resp) {
                  logD('resp:\n $resp');
                }).catchError((err) {
                  logE('获取订单id错误: $err');
                });
              } catch (e) {
                logE('catch: $e');
              }
            }),
            _customButton('商家接单, 上传收款码', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              var orderID = "406ec164-5ed5-4c57-a46e-0316f7fe9282";

              var ok = await OrderMod.takeOrder(orderID, filename);
              if (ok) {
                logD('上传完成');
              } else {
                logE('takeOrder错误');
              }
            }),
            _customButton('商家出票后拍照上链', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;
              
              //2419b9c8a937f5527d3124cf8618748ecc957b7535c505c818ed752d7a77597a
              // logD(hash);

              String orderID = Application.changeStateOrderID;
              UserMod.uploadOssOrderFile(filename, (imageKey) {
                logD('$filename 上传完成, imageKey: $imageKey');

                var f = OrderMod.uploadorderimage(filename, orderID, imageKey);
                f.then((value) {
                  logD('上传完成, value: $value');
                }).catchError((err) {
                  logE('uploadorderimage错误: $err');
                });
              }, (errmsg) {
                logD('拍照上传失败, $errmsg');
              }, (percent) {
                //上传进度
              });
            }),
            _customButton('更改订单状态为已完成', onTap: () async {
              String orderID = Application.changeStateOrderID;
              logD('orderID: $orderID');

              OrderStateEnum status = OrderStateEnum.OS_Done;
              ProductOrderType orderType = ProductOrderType.POT_Normal;
              var f = OrderMod.changeOrderStatus(orderID, status, orderType);
              f.then((value) {
                if (value == true) {
                  logD('更改订单($orderID)成功');
                }
              }).catchError((err) {
                logE(err);
              });
            }),
            _customButton('订单详情', onTap: () async {
              String orderID = Application.changeStateOrderID;
              logD('orderID: $orderID');

              OrderInfoData _data = await OrderMod.getOrder(orderID);
              logD('订单详情: ${_data.toJson()}');
            }),
            _customButton('商家id3所有订单', onTap: () async {
              int status = OrderStateEnum.OS_Prepare.index; //查询所有预审核
              var _list = await OrderMod.getOrders(status);
              logD('订单列表: $_list');
            }),
            _customButton('中奖后用户上传收款码', onTap: () async {
              final _imageFile =
                  await _picker.getImage(source: ImageSource.gallery);
              if (_imageFile == null) {
                return null;
              }
              var filename = _imageFile.path;

              var orderID = "406ec164-5ed5-4c57-a46e-0316f7fe9282";

              var ok = await OrderMod.acceptPrize(orderID, filename);
              if (ok) {
                logD('上传完成');
              } else {
                logE('acceptPrize错误');
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _customButton(String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
