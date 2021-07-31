import 'package:dio/dio.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/net/http.dart';
import 'package:linkme_flutter_sdk/net/cache.dart';

import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class HttpUtils {
  // static List<String> _returnMsg = [
  //   Urls.bindingDouyin,
  //   Urls.bindingWechat
  // ];

  static Options _options = Options();

  static void init({
    required String baseUrl,
    required int connectTimeout,
    required int receiveTimeout,
    List<Interceptor>? interceptors,
    String? token,
  }) {
    ///默认的header配置
//    _options.headers['content-type'] = 'application/json';
//    _options.headers['User-Agent'] = 'PostmanRuntime/7.26.5';
//    _options.headers['Accept'] = '*/*';
//    _options.headers['Host'] = 'api.lianmi.cloud';
//    _options.headers['Connection'] = 'keep-alive';

    Http().init(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 6000,
        interceptors: interceptors);
  }

  static void setHeaders(Map<String, dynamic> map) {
    _options.headers!.addAll(map);
  }

  static void cancelRequests({CancelToken? token}) {
    Http().cancelRequests(token: token);
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    // logD('调用get请求');
    var _data = await Http().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      noCache: noCache,
      cacheKey: cacheKey,
    );
    Map _m = _data as Map;
    if (_m['code'] == 401 || _m['code'] == 403) {
      ///token 已过期
      logI('登录过期，强制退出登录');
      if (AppManager.onTokenExpire != null) {
        AppManager.onTokenExpire!('token失效');
      }
      return null;
    }
    logV(_m);
    return _m;
  }

  static Future post(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    var _data = await Http().post(
      path,
      data: data,
      params: params,
      options: options ?? _options,
      cancelToken: cancelToken,
    );
    Map _m = _data as Map;
    // logD('post回包信息:' + _m.toString());
    if (_m['code'] == 401 || _m['code'] == 403) {
      ///token 已过期
      logW('登录过期，强制退出登录');
      if (AppManager.onTokenExpire != null) {
        AppManager.onTokenExpire!('token失效');
      }
      return null;
    }
    return _m;
  }

  static Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future postForm(
    String path, {
    required Map<String, dynamic> params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
