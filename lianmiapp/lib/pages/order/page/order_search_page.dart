import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/order/widgets/order_list_item.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

/// design/3订单/index.html#artboard8
class OrderSearchPage extends StatefulWidget {
  @override
  _OrderSearchPageState createState() => _OrderSearchPageState();
}

class _OrderSearchPageState extends State<OrderSearchPage> {
  String _keys = '';

  ///0:按出票码搜索  1:按订单ID搜索
  int _searchType = 0;

  List<OrderModel> _list = [];

  FocusNode _focusNode = FocusNode();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    NotificationCenter.instance.addObserver(NotificationDefine.orderUpdate, (
        {object}) {
      _searchOrders();
    });
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      _focusNode.requestFocus();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        _searchTop(),
                        _countWidget(),
                        _listArea(),
                      ],
                    )))));
  }

  Widget _searchTop() {
    return Container(
      width: double.infinity,
      height: 44.px,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 15.px),
              width: 40.px,
              height: 40.px,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8.px, right: 8.px),
              width: double.infinity,
              height: 32.px,
              decoration: BoxDecoration(color: Color(0xFFF4F5F6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: TextField(
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.search,
                          style:
                              TextStyle(fontSize: 16.px, color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 11.px),
                            border: InputBorder.none,
                            hintText: '搜索订单',
                            hintStyle: TextStyle(color: Colors.black26),
                            counterText: '',
                          ),
                          onSubmitted: (String text) {
                            _keys = text;
                            _searchOrders();
                          },
                        )),
                  ),
                  Gaps.hGap16,
                  InkWell(
                    child: Image.asset(
                      ImageStandard.orderTopDate,
                      width: 16.px,
                      height: 16.px,
                    ),
                    onTap: () {
                      _showDateSelect();
                    },
                  )
                ],
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 8.px),
              width: 40.px,
              height: double.infinity,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                ImageStandard.discoveryCategory,
                width: 16.px,
                height: 16.px,
              ),
            ),
            onTap: () {
              _showTypeSelect();
            },
          )
        ],
      ),
    );
  }

  Widget _countWidget() {
    if (_list.length > 0) {
      return Container(
        padding: ViewStandard.padding,
        width: double.infinity,
        height: 32.px,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: CommonText(
          '一共搜索到${_list.length}条订单',
          fontSize: 12.px,
          color: Color(0xFF999999),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _listArea() {
    return Expanded(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFF4F5F6),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              OrderModel model = _list[index];
              return OrderListItem(model);
            },
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    NotificationCenter.instance
        .removeNotification(NotificationDefine.orderUpdate);
  }

  void _showTypeSelect() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 150.px,
              child: ListView(
                // mainAxisSize: MainAxisSize.min, // 设置最小的弹出
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 50.px,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: CommonText(
                      '选择搜索类型',
                      fontSize: 18.px,
                      color: Colors.black,
                    ),
                  ),
                  CommonButton(
                    width: double.infinity,
                    height: 50.px,
                    color: Colors.white,
                    text: '按出票码搜索',
                    textColor: Colors.black,
                    fontSize: 16.px,
                    onTap: () {
                      Navigator.of(context).pop();
                      _searchType = 0;
                      _focusNode.requestFocus();
                    },
                  ),
                  CommonButton(
                    width: double.infinity,
                    height: 50.px,
                    color: Colors.white,
                    text: '按订单ID搜索',
                    textColor: Colors.black,
                    fontSize: 16.px,
                    onTap: () {
                      Navigator.of(context).pop();
                      _searchType = 1;
                      _focusNode.requestFocus();
                    },
                  ),
                ],
              ));
        });
  }

  void _showDateSelect() {
    _focusNode.unfocus();
    DateTime dateTime = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: double.infinity,
              height: 260.px,
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                      width: double.infinity,
                      height: 200.px,
                      child: CupertinoDatePicker(
                        initialDateTime: dateTime,
                        use24hFormat: true,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (date) {
                          dateTime = date;
                        },
                      )),
                  CommonButton(
                    margin: EdgeInsets.only(left: 40.px, right: 40.px),
                    width: double.infinity,
                    height: 40.px,
                    text: '确定',
                    color: Colours.app_main,
                    textColor: Colors.white,
                    borderRadius: 20.px,
                    onTap: () {
                      Navigator.of(context).pop();
                      _selectedDate = dateTime;
                      _searchOrders();
                    },
                  )
                ],
              ));
        });
  }

  void _searchOrders() async {
    int? ticketCode;
    if (_searchType == 0 && isNumeric(_keys)) {
      ticketCode = int.parse(_keys);
    }
    String? orderID;
    if (_searchType == 1 && isValidString(_keys)) {
      orderID = _keys;
    }
    int startTime = 0;
    int endTime = 0;
    if (_selectedDate != null) {
      startTime = _selectedDate!.millisecondsSinceEpoch;
      endTime = startTime + (24 * 60 * 60 * 1000);
    }
    HubView.showLoading();
    OrderMod.searchOrders(0,
            ticketCode: ticketCode,
            orderID: orderID,
            startTime: startTime,
            endTime: endTime,
            page: 0,
            limit: 1000)
        .then((value) async {
      HubView.dismiss();
      _list.clear();
      _list = await OrderModel.modelListFromServerDatas(value);
      logI(_list);
      _list.sort((OrderModel a, OrderModel b) {
        return b.orderTime!.compareTo(a.orderTime!);
      });
      logI(_list);
      setState(() {});
    }).catchError((err) {
      HubView.dismiss();
      HubView.showToastAfterLoadingHubDismiss('加载订单出错');
    });
  }
}
