import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/discovery/discovery_router.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/provider/main_tabbar_index_provider.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';

class OrderPayPage extends StatefulWidget {
  final OrderModel order;

  final double fee;

  OrderPayPage({required this.order, required this.fee});

  @override
  _OrderPayPageState createState() => _OrderPayPageState();
}

class _OrderPayPageState extends State<OrderPayPage> {
  int payMode = 1;

  @override
  void initState() {
    super.initState();
  }

  void _radioChange(v) {
    print(v);
    setState(() {
      this.payMode = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '支付方式选择',
      ),
      backgroundColor: Color(0XFFF4F5F6),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 80),
            Text(
              '请您注意',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 255),
                fontSize: 24.px,
              ),
            ),
            Divider(),
            Text(
              '商户根据支付方式给出收款码图片让您扫码支付',
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color(0xAA001133)),
            ),
            Divider(),
            Text(
              '您扫码支付之后，商户将直接到账',
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color(0xAA001133)),
            ),
            Divider(),
            Text(
              '除存证上链服务费,本App不向任何人收取订单的费用',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xAA001133),
              ),
            ),
            Divider(),
            //Flutter2.x以后调用RadioListTile的时候需要指定传入参数的类型  this.sex为int类型，所以这里我们指定为int类型
            RadioListTile<int>(
              value: 1,
              onChanged: this._radioChange,
              groupValue: this.payMode,
              title: Text("微信支付"),
              secondary: Image.asset(
                ImageStandard.wx,
                width: 24.px,
                height: 25.px,
              ),
              selected: this.payMode == 1,
            ),
            RadioListTile<int>(
              value: 2,
              onChanged: this._radioChange,
              groupValue: this.payMode,
              title: Text("支付宝"),
              secondary: Image.asset(
                ImageStandard.alipay,
                width: 24.px,
                height: 25.px,
              ),
              selected: this.payMode == 2,
            ),

            SizedBox(height: 80),
            Divider(),
            _bottomArea(),
          ],
        ),
      ),
    );
  }

  Widget _bottomArea() {
    return InkWell(
        onTap: () {
          _newOrder();
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(16.px, 0, 16.px, 80.px),
          width: double.infinity,
          height: 40.px,
          decoration: BoxDecoration(
              color: Color(0XFFFF4400),
              borderRadius: BorderRadius.all(Radius.circular(4.px))),
          alignment: Alignment.center,
          child: CommonText(
            '立即下单',
            fontSize: 16.px,
            color: Colors.white,
          ),
        ));
  }

  /// 调用下单接口下单
  void _newOrder() async {
    HubView.showLoading();

    OrderMod.preOrder(
      widget.order.businessUsername!,
      widget.order.productID!,
      widget.order.cost!,
      widget.order.toAttach(1), //0表示彩票类，1-存证类
      payMode: this.payMode, //1-微信支付，2-支付宝
    ).then((value) {
      // logD(value);
      HubView.dismiss();
      logD('下单成功，等待商户接单, cost: ${widget.order.cost!} 订单ID: $value');
      NotificationCenter.instance
          .postNotification(NotificationDefine.orderUpdate);
      // Navigator.of(context)
      //     .popUntil(ModalRoute.withName(DiscoveryRouter.storePage));

      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      Provider.of<MainTabbarIndexProvider>(context, listen: false).index = 1;
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss(err);
    });
  }
}
