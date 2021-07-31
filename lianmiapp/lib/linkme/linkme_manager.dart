import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

abstract class LinkMeManagerOrderStatusListerner {
  void onLinkMeOrderStatusChange(OrderInfoData orderInfoData);
}

abstract class LinkMeManagerAppSystemListerner {
  void onLinkMeInitAfter();
}

class LinkMeManager {
  factory LinkMeManager() => _getInstance();
  static LinkMeManager get instance => _getInstance();
  static LinkMeManager? _instance;
  LinkMeManager._internal() {}
  static LinkMeManager _getInstance() {
    if (_instance == null) {
      _instance = LinkMeManager._internal();
      AppManager.onReceiveOrder = (OrderInfoData orderInfoData) {
        logI('LinkMe_manager---订单监听:${orderInfoData.orderId}');
        for (LinkMeManagerOrderStatusListerner listener
            in _instance!._orderListeners) {
          listener.onLinkMeOrderStatusChange(orderInfoData);
        }
        _instance!._handleReceiveOrder(orderInfoData);
      };
    }
    return _instance!;
  }

  final List<LinkMeManagerOrderStatusListerner> _orderListeners = [];
  final List<LinkMeManagerAppSystemListerner> _appSystemListeners = [];

  ///用于初始化
  void init() {}

  // String getTextFromStatus(OrderStateEnum status) {
  //   String resultText = '';
  //   switch (status) {
  //     case OrderStateEnum.OS_Undefined:
  //       resultText = '';
  //       break;
  //     case OrderStateEnum.OS_Prepare:
  //       resultText = '预审核';
  //       break;
  //     case OrderStateEnum.OS_SendOK:
  //       resultText = '发送成功';
  //       break;
  //     case OrderStateEnum.OS_RecvOK:
  //       resultText = '送达成功';
  //       break;
  //     case OrderStateEnum.OS_Taked:
  //       resultText = '已接单';
  //       break;
  //     case OrderStateEnum.OS_Done:
  //       resultText = '已完成';
  //       break;
  //     case OrderStateEnum.OS_Cancel:
  //       resultText = '已取消';
  //       break;
  //     case OrderStateEnum.OS_Processing:
  //       resultText = '处理中';
  //       break;
  //     case OrderStateEnum.OS_Confirm:
  //       resultText = '已收货';
  //       break;
  //     case OrderStateEnum.OS_ApplyCancel:
  //       resultText = '申请撤单';
  //       break;
  //     case OrderStateEnum.OS_AttachChange:
  //       resultText = '订单已改变';
  //       break;
  //     case OrderStateEnum.OS_Paying:
  //       resultText = '支付中';
  //       break;
  //     case OrderStateEnum.OS_Overdue:
  //       resultText = '已逾期';
  //       break;
  //     case OrderStateEnum.OS_Refuse:
  //       resultText = '已拒单';
  //       break;
  //     case OrderStateEnum.OS_IsPayed:
  //       resultText = '已支付';
  //       break;
  //     case OrderStateEnum.OS_Urge:
  //       resultText = '商户催单';
  //       break;
  //     case OrderStateEnum.OS_Expedited:
  //       resultText = '紧急';
  //       break;
  //     default:
  //   }
  //   return resultText;
  // }

  // String getTextFromIntStatus(int status) {
  //   return getTextFromStatus(OrderStateEnum.values[status]);
  // }

  bool isLegelOrderFromStatus(int status) {
    if (status == OrderStateEnum.OS_IsPayed.index ||
        status == OrderStateEnum.OS_Done.index ||
        status == OrderStateEnum.OS_Confirm.index ||
        status == OrderStateEnum.OS_Refuse.index) {
      return true;
    } else {
      return false;
    }
  }

  ///消息监听
  void addOrderListener(LinkMeManagerOrderStatusListerner listener) {
    _orderListeners.add(listener);
  }

  void removeOrderListener(LinkMeManagerOrderStatusListerner listener) {
    _orderListeners.remove(listener);
  }

  void addAppSystemListener(LinkMeManagerAppSystemListerner listener) {
    _appSystemListeners.add(listener);
  }

  void removeAppSystemListener(LinkMeManagerAppSystemListerner listener) {
    _appSystemListeners.remove(listener);
  }

  void _handleReceiveOrder(OrderInfoData orderInfoData) {}
}
