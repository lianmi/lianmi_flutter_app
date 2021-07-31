import 'package:flutter/material.dart';
import 'message_response.dart';

/// Enumeration that indicates various client connection states
enum WebsocketConnectionState {
  /// Websocket Connection is not currently connected to any ws server.
  disconnected,

  /// The Websocket Connection is currently connected to the ws server.
  connected,
}

class WebsocketModel with ChangeNotifier {
  WebsocketConnectionState _state = WebsocketConnectionState.disconnected;

  WebsocketConnectionState get state => _state;

  bool _isLogined = false;

  bool get isLogined => _isLogined;

  @override
  void dispose() {
    super.dispose();
  }
}

//网络连接
class WebsocketStateEvent {
  WebsocketConnectionState state;

  WebsocketStateEvent(this.state);
}

//是否登录
class WebsocketLoginedEvent {
  bool isLogined;

  WebsocketLoginedEvent(this.isLogined);
}

//服务端下发数据
class WebsocketMessageEvent {
  Response response;

  WebsocketMessageEvent(this.response);
}
