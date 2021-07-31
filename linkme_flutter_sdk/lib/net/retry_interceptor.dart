import 'dart:io';

import 'package:dio/dio.dart';

import 'connectivity_request_retrier.dart';

///在网络断开的时候，监听网络，等重连的时候重试
class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      return super.onError(err, handler);
//      try {
//
//      } catch (e) {
//        debugPrint('onError:$e');
//      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
