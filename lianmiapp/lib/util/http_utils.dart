import 'package:dio/dio.dart';
import 'package:lianmiapp/http/cache.dart';
import 'package:lianmiapp/http/http.dart';

import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class HttpUtils {
  static Options _options = Options();

  static void init({
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
    String? token,
  }) {
    var headersMap = new Map<String, dynamic>();
    headersMap["content-type"] = 'application/json';
    headersMap['User-Agent'] = 'PostmanRuntime/7.26.5';
    headersMap['Accept'] = '*/*';

    headersMap['Host'] = 'api.lianmi.cloud';
    headersMap['Connection'] = 'keep-alive';
    headersMap['token'] = '';
    _options.headers = headersMap;

    Http().init(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
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
    if (_m['data'] != null) {
      return _m['data'];
    } else if (_m.keys.length > 0) {
      return _m;
    } else {
      return null;
    }
    // if (_m.keys.length > 0){
    //   return _m;
    // }
    // return _m['data'] ?? null;
  }

  static Future post(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    logD('请求头:' + (options ?? _options).headers.toString());
    var _data = await Http().post(
      path,
      data: data,
      params: params,
      options: options ?? _options,
      cancelToken: cancelToken,
    );

    Map _m = _data as Map;
    return _m['data'] ?? null;
    // return _m;

    // var code =_m['code'];
    // if (code ==200) {

    // } else {
    //   return _] ?? null;
    // }
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
    Map<String, dynamic>? params,
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
