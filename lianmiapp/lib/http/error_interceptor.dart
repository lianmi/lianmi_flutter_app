import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app_exceptions.dart';

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // error统一处理,调用AppException方法处理（app_exceptions.dart）
    AppException appException = AppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;
    //lishijia
    return super.onError(err, handler);
  }
}
