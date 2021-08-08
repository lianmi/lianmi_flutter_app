import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/order/widgets/order_type_widget.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/pages/order/widgets/order_list_item.dart';

List<OrderStateEnum> _statusListUser = [
  OrderStateEnum.OS_Undefined,
  OrderStateEnum.OS_Prepare,
  OrderStateEnum.OS_Confirm,
  OrderStateEnum.OS_Done,
  OrderStateEnum.OS_Refuse,
];
List<OrderStateEnum> _statusListShop = [
  OrderStateEnum.OS_Undefined,
  OrderStateEnum.OS_IsPayed,
  OrderStateEnum.OS_Confirm,
  OrderStateEnum.OS_Done,
  OrderStateEnum.OS_Refuse,
];

List<String> _statusUserTitles = ['全部', '待接单', '已确认', '已完成', '已拒单'];

List<String> _statusShopTitles = ['全部', '已支付', '已确认', '已完成', '已拒单'];

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin
    implements LinkMeManagerOrderStatusListerner {
  int _currentStatusIndex = 0;

  List<OrderModel> _list = [];

  ScrollController _scrollController = ScrollController();
  MyRefreshController _refreshController = MyRefreshController();

  @override
  void initState() {
    super.initState();
    LinkMeManager.instance.addOrderListener(this);
    NotificationCenter.instance.addObserver(NotificationDefine.orderUpdate, (
        {object}) {
      _loadOrders();
    });
    _loadOrders();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: SafeArea(
                top: false,
                child: Offstage(),
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              width: double.infinity,
              child: Column(
                children: [
                  OrderTypeWidget(
                    icons: [
                      ImageStandard.orderStatus0,
                      ImageStandard.orderStatus1,
                      ImageStandard.orderStatus2,
                      ImageStandard.orderStatus5,
                      ImageStandard.orderStatus3,
                    ],
                    titles: App.isShop ? _statusShopTitles : _statusUserTitles,
                    onTap: (int index) {
                      _currentStatusIndex = index;
                      // logI('_currentStatusIndex: $_currentStatusIndex');

                      _refreshController.callRefresh();
                    },
                  ),
                  _listWidget()
                ],
              ),
            )));
  }

  Widget _listWidget() {
    return Expanded(
      child: MyRefreshWidget(
        headerBackgroundColor: Colours.bg_color,
        scrollController: _scrollController,
        refreshController: _refreshController,
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return OrderListItem(_list[index]);
        },
        refreshCallback: () {
          _loadOrders();
        },
        // loadMoreCallback: () {
        //   _loadMoreOrders();
        // },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    NotificationCenter.instance
        .removeNotification(NotificationDefine.orderUpdate);
  }


  void _loadOrders() async {
    int orderStatus = 0;
    if (App.isShop) {
      orderStatus = _statusListShop[_currentStatusIndex].index;
    } else {
      orderStatus = _statusListUser[_currentStatusIndex].index;
    }
    OrderMod.getOrders(orderStatus, page: 0, limit: 100).then((value) async {
      _refreshController.finishRefresh();
      _refreshController.finishLoad();
      _refreshController.finishLoad(noMore: true);
      _list.clear();
      _list = await OrderModel.modelListFromServerDatas(value);
      // _list.forEach((element) {
      //   logI(element.toJson());
      // });

      _list.sort((OrderModel a, OrderModel b) {
        return b.orderTime!.compareTo(a.orderTime!);
      });
      // print(_list);
      setState(() {});
    }).catchError((err) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad();
      _refreshController.finishLoad(noMore: true);
    });
  }

  void _loadMoreOrders() async {
    int orderStatus = 0;
    if (App.isShop) {
      orderStatus = _statusListShop[_currentStatusIndex].index;
    } else {
      orderStatus = _statusListUser[_currentStatusIndex].index;
    }

    OrderMod.getOrders(orderStatus, page: _list.length, limit: 100)
        .then((value) async {
      _refreshController.finishRefresh();
      _refreshController.finishLoad();
      List<OrderModel> moreList =
          await OrderModel.modelListFromServerDatas(value);
      _list.addAll(moreList);
      _list.sort((OrderModel a, OrderModel b) {
        return b.orderTime!.compareTo(a.orderTime!);
      });
      setState(() {});
    }).catchError((err) {
      _refreshController.finishRefresh();
      _refreshController.finishLoad();
    });
  }

  @override
  void onLinkMeOrderStatusChange(OrderInfoData orderInfo) {
    logI(
        '用户的订单列表收单订单变更通知, orderid:${orderInfo.orderId},status:${orderInfo.state}');
    _loadOrders();
  }
}
