import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';

class OrderChangeCostPage extends StatefulWidget {
  final OrderModel order;

  OrderChangeCostPage(this.order);

  @override
  _OrderChangeCostPageState createState() => _OrderChangeCostPageState();
}

class _OrderChangeCostPageState extends State<OrderChangeCostPage> {
  TextEditingController _countController = TextEditingController();
  TextEditingController _multipleController = TextEditingController();

  @override
  initState() {
    super.initState();

    _countController.text = widget.order.count.toString();
    _multipleController.text = widget.order.multiple.toString();
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
            '单价',
            fontSize: 14.px,
            color: Colors.black,
          ),
          Gaps.hGap16,
          Expanded(child: Text('2.0')),
          CommonText(
            '数量',
            fontSize: 14.px,
            color: Colors.black,
          ),
          Gaps.hGap16,
          Expanded(
              child: TextField(
            controller: _countController,
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
              hintText: '请输入数量',
              hintStyle: TextStyle(color: Colors.black26),
              counterText: '',
            ),
            onSubmitted: (String text) {
              //
            },
          )),
          CommonText(
            '倍数',
            fontSize: 14.px,
            color: Colors.black,
          ),
          Gaps.hGap16,
          Expanded(
              child: TextField(
            controller: _multipleController,
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
              hintText: '请输入倍数',
              hintStyle: TextStyle(color: Colors.black26),
              counterText: '',
            ),
            onSubmitted: (String text) {
              //
            },
          )),
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
    if (isValidString(_countController.text) == false) {
      HubView.showToast('请输入数量');
      return;
    }
    int _count = int.parse(_countController.text);
    if (_count <= 0) {
      HubView.showToast('数量错误');
      return;
    }
    int _multiple = int.parse(_multipleController.text);
    if (_count <= 0) {
      HubView.showToast('倍数错误');
      return;
    }

    if (widget.order.status != OrderStateEnum.OS_Prepare) {
      HubView.showToast('订单状态为待接单时方可修改价格');
      return;
    }

    // 带参数的返回
    AppNavigator.goBackWithParams(context,
        {'count': _countController.text, 'multiple': _multipleController.text});
  }
}
