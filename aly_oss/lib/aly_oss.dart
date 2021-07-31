import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AlyOss {
  /// 静态通道
  static final _channel = MethodChannel('lianmi.cloud/aly_oss')
    ..setMethodCallHandler(_handler);
  static final _instances = Map<String, AlyOss>();
  static final _uuid = Uuid();
  late String _instanceId;

  AlyOss() {
    _instanceId = _uuid.v4();
    _instances[_instanceId] = this; //

    print('AlyOss: ' + _instanceId);
  }

  StreamController<ProgressResponse> _onProgressController =
      StreamController<ProgressResponse>.broadcast();

  Stream<ProgressResponse> get onProgress => _onProgressController.stream;

  StreamController<UploadResponse> _onUploadController =
      StreamController<UploadResponse>.broadcast();

  Stream<UploadResponse> get onUpload => _onUploadController.stream;

  /// 处理器, 处理来自安卓或iOS的方法调用，一般用于回调
  static Future<dynamic> _handler(MethodCall methodCall) async {
    String instanceId = methodCall.arguments['instanceId'];
    AlyOss instance = _instances[instanceId]!;

    switch (methodCall.method) {
      case 'onProgress':
        instance._onProgressController
            .add(ProgressResponse.fromMap(methodCall.arguments));
        break;
      case 'onUpload': //上传完成
        instance._onUploadController
            .add(UploadResponse.fromMap(methodCall.arguments));
        break;
      default:
        print(
            'Call ${methodCall.method} from platform, arguments=${methodCall.arguments}');
    }

    return Future.value(true);
  }

  /// Initialize plugin with [request]
  Future<Map<String, dynamic>?> init(InitRequest request) async {
    return await _invokeMethod('init', request.toMap());
  }

  /// Shutdown plugin
  void shutdown() {
    _onProgressController.close();
    _onUploadController.close();
  }

  /// 上传
  Future<Map<String, dynamic>?> upload(UploadRequest request) async {
    return await _invokeMethod('upload', request.toMap());
  }

  /// 判断文件是否存在
  Future<Map<String, dynamic>?> exist(KeyRequest request) async {
    return await _invokeMethod('exist', request.toMap());
  }

  /// 删除
  Future<Map<String, dynamic>?> delete(KeyRequest request) async {
    return await _invokeMethod('delete', request.toMap());
  }

  /// 调用方法
  Future<Map<String, dynamic>?> _invokeMethod(String method,
      [Map<String, dynamic> arguments = const {}]) {
    Map<String, dynamic> withId = Map.of(arguments);
    withId['instanceId'] = _instanceId;

    return _channel.invokeMapMethod(method, withId);
  }
}

/// 请求基类
abstract class Request {
  final String requestId;

  Request(this.requestId);

  Map<String, dynamic> toMap() {
    return {'requestId': requestId};
  }
}

/// 初始化请求类
class InitRequest extends Request {
  final String endpoint;
  final String accessKeyId;
  final String accessKeySecret;
  final String securityToken;
  final String expiration;

  InitRequest(requestId, this.endpoint, this.accessKeyId, this.accessKeySecret,
      this.securityToken, this.expiration)
      : super(requestId);

  Map<String, dynamic> toMap() {
    var m = Map.of(super.toMap());
    m['endpoint'] = endpoint;
    m['accessKeyId'] = accessKeyId;
    m['accessKeySecret'] = accessKeySecret;
    m['securityToken'] = securityToken;
    m['expiration'] = expiration;

    return m;
  }
}

/// 秘钥请求类
class KeyRequest extends Request {
  final String bucket;
  final String key;

  KeyRequest(requestId, this.bucket, this.key) : super(requestId);

  Map<String, dynamic> toMap() {
    var m = Map.of(super.toMap());
    m['bucket'] = bucket;
    m['key'] = key;

    return m;
  }
}

/// 上传请求类
class UploadRequest extends KeyRequest {
  final String file;

  UploadRequest(requestId, bucket, key, this.file)
      : super(requestId, bucket, key);

  Map<String, dynamic> toMap() {
    var m = Map.of(super.toMap());
    m['file'] = file;

    return m;
  }
}

/// 回包基类
abstract class Response {
  final bool? success;
  final String? requestId;

  Response({this.success, this.requestId});
}

///  秘钥回包类
class KeyResponse extends Response {
  final String? bucket;
  final String? key;

  KeyResponse({success, requestId, this.bucket, this.key})
      : super(success: success, requestId: requestId);
}

/// 上传回包
class UploadResponse extends KeyResponse {
  UploadResponse({success, requestId, bucket, key})
      : super(success: success, requestId: requestId, bucket: bucket, key: key);

  UploadResponse.fromMap(Map map)
      : super(
          success: "true" == map['success'],
          requestId: map['requestId'],
          bucket: map['bucket'],
          key: map['key'],
        );

  String toString() {
    return '{success:$success, requestId:$requestId, bucket:$bucket, key:$key}';
  }
}

///  进度条类
class ProgressResponse extends KeyResponse {
  int? currentSize;
  int? totalSize;

  ProgressResponse(
      {success, requestId, bucket, key, this.currentSize, this.totalSize})
      : super(success: success, requestId: requestId, bucket: bucket, key: key);

  ProgressResponse.fromMap(Map map)
      : super(
          success: "true" == map['success'],
          requestId: map['requestId'],
          bucket: map['bucket'],
          key: map['key'],
        ) {
    currentSize = int.tryParse(map['currentSize']) ?? 0;
    totalSize = int.tryParse(map['totalSize']) ?? 0;
  }

  String toString() {
    return '{success:$success, requestId:$requestId, bucket:$bucket, key:$key}, currentSize:$currentSize, totalSize:$totalSize';
  }
}
