abstract class BaseConnectionListener {
  /// 网络已连接
  void onConnected();

  /// 连接失败
  void onDisconnected();
}

/// @nodoc 同步事件监听器
abstract class SyncEventListener {
  ///所有同步完成
  void onSyncDone();
}
