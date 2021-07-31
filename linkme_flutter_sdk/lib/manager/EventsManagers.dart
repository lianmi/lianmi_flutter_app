import 'package:linkme_flutter_sdk/manager/NetworkResponse.dart';
import 'package:linkme_flutter_sdk/manager/event/KickedEvent.dart';
import 'package:linkme_flutter_sdk/manager/event/RecvMsg.dart';
import 'EventBase.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class EventsManagers {
  //私有构造函数
  EventsManagers._internal();
  static final EventsManagers api = new EventsManagers._internal();

  //工厂构造函数
  factory EventsManagers() => api;

  static Map<String, EventBase>? event_maps;

  /// 初始化
  /// 仅在 空的时候初始化
  init() {
    if (event_maps == null) {
      event_maps = new Map();
    } else {
      event_maps!.clear();
    }

    registerMod(new OnKicked()); // 注册 2-5 在线设备被踢下线事件
    // registerMod(new OnSyncWatching()); // 3-11 关注商户同步事件
    registerMod(new OnRecvMsg()); // 注册 5-2 订单消息接收事件
    // registerMod(new OnSyncSystemMsg()); // 5-9 同步系统公告事件
    // registerMod(new OnSyncDoneEvent()); // 注册 6-2 同步请求完成
  }

  /// 注册一个模块
  /// [event] 需要监听的模块的实现
  registerMod(EventBase event) {
    if (event_maps == null) {
      logW("尚未初始化监听器");
      return;
    }

    /// 判断是否为空 , 如果是空的则 插入 ， 不为空的不处理
    String currentKey = "mod_${event.getType()}_${event.getSubType()}";
    // logD('currentKey: $currentKey');
    if (event_maps!.containsKey(currentKey)) {
      /// 存在
      logD(
          "该模块已经注册过了, Type =  ${event.getType()} SubType = ${event.getSubType()}");
      return;
    }
    event_maps![currentKey] = event;
  }

  //回调
  dispatch(NetworkResponse response) {
    String currentKey = 'mod_${response.businessKey}';
    // logD("dispatch currentKey: $currentKey");
    bool havekey = event_maps!.containsKey(currentKey);
    if (!havekey) {
      logD("没有这个事件 业务: $currentKey");
      return;
    }

    /// 触发监听器
    event_maps![currentKey]!.onMessage(response);
  }
}

//定义一个top-level变量，页面引入该文件后可以直接使用
var eventsManagers = new EventsManagers();
