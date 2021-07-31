import 'NetworkResponse.dart';

/// 事件监听模块基本抽象累
abstract class EventBase {
  /// 获取 业务类型的值
  int getType();

  /// 获取业务子类型的值
  int getSubType();

  /// 当收到对应的业务的时候 触发的事件处理过程
  /// [response] 服务端下发的数据包
  onMessage(NetworkResponse response);
}
