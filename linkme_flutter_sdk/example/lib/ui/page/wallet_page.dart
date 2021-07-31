import 'package:linkme_flutter_sdk/sdk/WalletMod.dart';
import '../widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("wallet", 80, false).build(context),
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
            _customButton('查询余额', onTap: () async {
              var balance = await WalletMod.getBalance();
              logD('balance: $balance');
            }),
            _customButton('支付宝充值', onTap: () async {
              //充值1元
              var payParam = await WalletMod.aliPrepay(1.00);
              logD('payParam: $payParam');
            }),
            _customButton('微信充值', onTap: () async {
              //充值1元
              var _data = await WalletMod.wxPrepay(1.00);
              logD('_data: $_data');
            }),
            _customButton('充值历史', onTap: () async {
              var result = await WalletMod.getTransactions(0, 0);
              logD('result: $result');
            }),
            _customButton('手续费消费历史', onTap: () async {
              var result = await WalletMod.getSpendings(0, 0);
              logD('result: $result');
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
