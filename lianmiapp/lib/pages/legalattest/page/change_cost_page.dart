import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';

class ChangeCostPage extends StatefulWidget {
  final OrderModel order;

  ChangeCostPage(this.order);

  @override
  _ChangeCostPageState createState() => _ChangeCostPageState();
}

class _ChangeCostPageState extends State<ChangeCostPage> {
  TextEditingController _textController = TextEditingController(
      // text: widget.order.price,
      );

  @override
  initState() {
    super.initState();
    double _cost;
    if (widget.order.cost == null) {
      _cost = 2;
    } else {
      _cost = (widget.order.cost!);
    }

    _textController.text = _cost.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '商户修改价格',
        ),
        backgroundColor: Color(0XFFF4F5F6),
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.px),
                width: double.infinity,
                height: 317.px,
                color: Colors.white,
                child: Column(
                  children: [_moneyArea()], //, _photoArea()
                ),
              ),
              _detailBottomButton('确定', onTap: () {
                _confirm();
              })
            ],
          ),
        )));
  }

  Widget _moneyArea() {
    return Container(
      padding: ViewStandard.padding,
      width: double.infinity,
      height: 54.px,
      child: Row(
        children: [
          CommonText(
            '订单价格',
            fontSize: 14.px,
            color: Colors.black,
          ),
          Gaps.hGap16,
          Expanded(
              child: TextField(
            controller: _textController,
            textAlign: TextAlign.left,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 14.px, color: Colors.black),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16)
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入兑奖金额',
              hintStyle: TextStyle(color: Colors.black26),
              counterText: '',
            ),
            onSubmitted: (String text) {},
          ))
        ],
      ),
    );
  }

  Widget _detailBottomButton(String title,
      {double topMargin = 0, required Function onTap}) {
    return InkWell(
        onTap: () {
          onTap();
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

  void _confirm() {
    if (isValidString(_textController.text) == false) {
      HubView.showToast('请输入订单价格');
      return;
    }
    double _price = double.parse(_textController.text);
    if (_price <= 0) {
      HubView.showToast('订单价格错误');
      return;
    }

    if (widget.order.status != OrderStateEnum.OS_Prepare) {
      HubView.showToast('订单状态为待接单时方可修改价格');
      return;
    }

    // 带参数的返回
    AppNavigator.goBackWithParams(context, {'cost': _textController.text});
  }
}
