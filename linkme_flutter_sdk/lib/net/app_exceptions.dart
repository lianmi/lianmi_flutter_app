import 'dart:convert';

// import 'package:linkme_flutter_sdk/events/isolate/isolate_events.dart';
// import 'package:linkme_flutter_sdk/util/common/common_header.dart';
import 'package:dio/dio.dart';

import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/// 自定义异常
class AppException implements Exception {
  final String? _message;
  final int? _code;
  AppException([
    this._code,
    this._message,
  ]);
  String toString() {
    return "$_code$_message";
  }

  factory AppException.create(DioError error) {
    ///接口白名单（处理401）
    // List<String> _white = [
    //   Urls.baseUrl + '/v1/user/login',
    //   Urls.baseUrl + '/register'
    // ];
//    LogUtils.logger.e(
//      logModel(
//        error: error.error.toString(),
//        remind: jsonEncode({
//          'error请求头': error.requestOptions.headers.toString(),
//          'error请求数据': error.requestOptions.data.toString(),
//          '请求uri': error.requestOptions.uri.toString()
//        })
//      )
//    );
    logE(error.message);
    try {
      switch (error.type) {
        case DioErrorType.cancel:
          {
            // if (IsolateEvents.db != null) {
            //   ShowToastCircle('请求已取消');
            // }
            return BadRequestException(-1, "请求取消");
          }
        case DioErrorType.connectTimeout:
          {
            // if (IsolateEvents.db != null) {
            //   ShowToastCircle('连接超时，请检查您的网络');
            // }
            return BadRequestException(-1, "连接超时");
          }
        case DioErrorType.sendTimeout:
          {
            // if (IsolateEvents.db != null) {
            //   ShowToastCircle('请求超时，请检查您的网络');
            // }
            return BadRequestException(-1, "请求超时");
          }
        case DioErrorType.receiveTimeout:
          {
            return BadRequestException(-1, "响应超时");
          }
        case DioErrorType.other:

          ///token过期或其他原因
          {
            // LogUtils.logger.i('app——exceptions回包代码: ${error.error}');
            // LogUtils.logger.i('app——exceptions回包字段: ${error.response}');
            // if (Application.isLogin() &&
            //     error.error
            //         .toString()
            //         .contains('Failed to parse header value')) {
            //   if (_white.contains(error.requestOptions.uri.toString())) {
            //     LogUtils.logger.i('登录失败白名单');
            //     return BadRequestException(-1, "登录失败白名单");
            //   } else {
            //     LogUtils.logger.i('错误的请求回包: ${error.response?.statusCode}');
            //     Provider.of<UserInfoViewModel>(Application.context!,
            //             listen: false)
            //         .logout()
            //         .then((value) {
            //       Routes.navigateTo(Application.context, Routes.root);
            //     });
            //   }
            //   return BadRequestException(-1, "token过期，请重新登录");
            // } else if (error.response == null) {
            //   if (IsolateEvents.db != null) {
            //     ShowToastCircle('请检查网络');
            //   }
            //   return BadRequestException(-1, "网络错误");
            // }
            return BadRequestException(-1, "网络错误");
          }
        case DioErrorType.response:
          {
            int? errCode = error.response!.statusCode;
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(errCode, "请求语法错误");
                }
              case 401:

                ///token 过期，不可用
                {
                  // Provider.of<UserInfoViewModel>(Application.context!,
                  //         listen: false)
                  //     .logout()
                  //     .then((value) {
                  //   Routes.navigateTo(Application.context, Routes.root);
                  // });
                  return UnauthorisedException(errCode, "没有权限");
                }
              case 403:
                {
                  return UnauthorisedException(errCode, "服务器拒绝执行");
                }
              case 404:
                {
                  return UnauthorisedException(errCode, "无法连接服务器");
                }
              case 405:
                {
                  return UnauthorisedException(errCode, "请求方法被禁止");
                }
              case 500:
                {
                  return UnauthorisedException(errCode, "服务器内部错误");
                }
              case 502:
                {
                  return UnauthorisedException(errCode, "无效的请求");
                }
              case 503:
                {
                  return UnauthorisedException(errCode, "服务器挂了");
                }
              case 505:
                {
                  return UnauthorisedException(errCode, "不支持HTTP协议请求");
                }
              default:
                {
                  return AppException(errCode, error.response!.statusMessage);
                }
            }
          }
      }
    } catch (e) {
      logE(e.toString());
      // LogUtils.logger.e(logModel(
      //     remind: error.requestOptions.uri.toString(), error: e.toString()));
      return AppException(-1, error.message);
    }
  }
}

/// 请求错误
class BadRequestException extends AppException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends AppException {
  UnauthorisedException([int? code, String? message]) : super(code, message);
}
