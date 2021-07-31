import 'dart:async';
import 'dart:convert';

import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/manager/EventsManagers.dart';
import 'package:linkme_flutter_sdk/manager/NetworkResponse.dart';
import 'package:linkme_flutter_sdk/models/message_response.dart';
import 'package:linkme_flutter_sdk/sdk/Listeners.dart';
import 'package:linkme_flutter_sdk/util/hex.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import '../models/websocket_model.dart';
import '../common/EventBus.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

const String _SERVER_ADDRESS = "wss://api.lianmi.cloud/acc";

IOWebSocketChannel _channel = IOWebSocketChannel.connect(_SERVER_ADDRESS);

late Timer _timer;

bool _disconnected = true;

bool _isWsLogined = false;

bool _isLogout = false;

int _times = 0;

int _appId = 101;

//订阅者回调签名
typedef void EventCallback(WebsocketMessageEvent arg);

class WebSocketHandlerFactory {
  // 网络连接消息监听器
  static final List<BaseConnectionListener> _connectionListeners = [];

  //私有构造函数
  WebSocketHandlerFactory._internal();
  static final WebSocketHandlerFactory _sockets =
      new WebSocketHandlerFactory._internal();

  //工厂构造函数
  factory WebSocketHandlerFactory() => _sockets;

  // WebsocketEventBus _bus = new WebsocketEventBus();

  // WebsocketEventBus get wsbus => _bus;

  bool get isWsLogined => _isWsLogined;

  /// @nodoc add Listener - Adds [listener] to be aware of team change events.
  void addNetWorkListener(BaseConnectionListener listener) {
    _connectionListeners.add(listener);
  }

  /// @nodoc remove Listener - Remove [listener] from the listener list.
  void removeNetWorkListener(BaseConnectionListener listener) {
    _connectionListeners.remove(listener);
  }

  // 监听消息
  void _addEvent() {
    bus.on<WebsocketStateEvent>().listen((WebsocketStateEvent event) {
      if (event.state == WebsocketConnectionState.connected) {
        //服务器连接成功
        logD('服务器连接成功');
        for (var lister in _connectionListeners) {
          lister.onConnected();
          break;
        }
      } else if (event.state == WebsocketConnectionState.disconnected) {
        //服务器断连
        logW('服务器断连');
        for (var lister in _connectionListeners) {
          lister.onDisconnected();
          break;
        }
      }
    });

    bus.on<WebsocketLoginedEvent>().listen((WebsocketLoginedEvent event) {
      if (event.isLogined) {
        logD('用户已登录');
        // AppManager
      } else {
        logW('用户未登录');
      }
    });
  }

  //初始化
  create(String token) {
    _addEvent();
  }

  void initCommunication() async {
    reset();

    try {
      _times += 1;
      logD("try to connect url:$_SERVER_ADDRESS,  $_times time(s)");
      _channel = new IOWebSocketChannel.connect(_SERVER_ADDRESS);
      bus.fire(new WebsocketStateEvent(WebsocketConnectionState.connected));
      _disconnected = false;

      _channel.stream.listen(_onReceptionOfMessage, onError: (error) {
        logD(error);
      }, onDone: () {
        _disconnected = true;
        _isWsLogined = false;

        bus.fire(
            new WebsocketStateEvent(WebsocketConnectionState.disconnected));

        logD('ws连接已断开...');
        Future.delayed(Duration(seconds: 3), () => reLogin());
      });
    } catch (e) {
      logD(e);
    }
  }

  void startTimer() {
    if (_isLogout) return;
    //设置 15 秒回调一次
    const period = const Duration(seconds: 15);
    _timer = Timer.periodic(period, (timer) {
      var obj = {
        'seq': Uuid().v4(),
        'cmd': 'heartbeat', //heartbeat
      };
      send(json.encode(obj).toString());
    });
  }

  void reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
        _disconnected = true;
      }
    }
  }

  // 发送登录
  void doLogin() {
    _isLogout = false;

    var data = {
      'userId': AppManager.currentUsername, //TODO 测试，实际不需要
      'serviceToken': AppManager.currentToken!, //令牌
      'appId': _appId, // app id
    };

    var obj = {
      'seq': Uuid().v4(),
      'cmd': 'login',
      'data': data,
    };

    String text = json.encode(obj).toString();
    send(text);
  }

  void reLogin() {
    var data = {
      'userId': AppManager.currentUsername, //TODO 测试，实际不需要
      'serviceToken': AppManager.currentToken!, //令牌
      'appId': _appId, // app id
    };
    var obj = {
      'seq': Uuid().v4(),
      'cmd': 'login',
      'data': data,
    };
    String text = json.encode(obj).toString();
    // logD(text);
    send(text);
  }

  //断开连接
  void logout() {
    _isLogout = true;
    try {
      if (_timer.isActive) {
        _timer.cancel();
      }
    } catch (e) {
      logE(e);
    }
    _channel.sink.close();
    _disconnected = false;
  }

  void send(String message) {
    ///check connection before send message
    if (_isLogout) {
      //主动登出后不能重连
      return;
    }
    if (_disconnected) {
      logD('init connecting...');
      initCommunication();
    }
    if (_channel != null) {
      if (_channel.sink != null && _disconnected == false) {
        String event = 'message';
        String data = jsonEncode({'type': event, 'data': message});
        _channel.sink.add(data);
      }
    }
  }

  void _onReceptionOfMessage(message) {
    _disconnected = false;

    // logD(message);

    var jmessage = jsonDecode(message);
    var seq = jmessage['seq'];
    var cmd = jmessage['cmd'];
    var data = jmessage['data'];
    // logD('seq: $seq, cmd: $cmd, data: $data');

    var _response = jmessage['response'];
    // logD('_response: $_response');
    if (_response != null) {
      if (cmd == 'login') {
        logD('cmd: $cmd, data: $_response');
        _isWsLogined = true;
        startTimer();
      }
      if (_response['data'] == 'pong') {
        logD('ws连接正常...');
      } else {
        if (_response['data'] != null) {
          Response response = Response(
              code: _response['code'],
              codeMsg: _response['codeMsg'],
              data: Data.fromJson(_response['data']));

          Uri uri = Uri.parse(response.data.target);
          if (uri.scheme != 'lianmi') {
            logW('体系不匹配: 这里是 lianmi, 避免其他app冲突');
            return;
          }
          String businessKey = uri.host;
          logD('_onReceptionOfMessage, businessKey: $businessKey'); //用于存放业务

          NetworkResponse networkResponse = new NetworkResponse();
          networkResponse.code = _response['code'];
          networkResponse.errormsg = _response['codeMsg'];
          networkResponse.businessKey = businessKey;
          networkResponse.msgBody = Hex.decode(response.data.msg);

          //回调
          eventsManagers.dispatch(networkResponse);
        }
      }
    }
  }
}

//定义一个top-level变量，页面引入该文件后可以直接使用bus
var websocketfactory = new WebSocketHandlerFactory();
/*
class WebsocketEventBus {
  //私有构造函数
  WebsocketEventBus._internal();

  //保存单例
  static WebsocketEventBus _singleton = new WebsocketEventBus._internal();

  //工厂构造函数
  factory WebsocketEventBus() => _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, EventCallback>();

  //添加订阅者
  void on(dynamic eventName, EventCallback f) {
    if (eventName == null) return;
    _emap[eventName] = f;
  }

  //移除订阅者
  void off(dynamic eventName) {
    _emap[eventName];
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  bool emit(dynamic eventName, [arg]) {
    var f = _emap[eventName];
    if (f == null) return false;
    f(arg);
    return true;
  }
}
*/