import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/net/proxy.dart';
import 'package:linkme_flutter_sdk/net/retry_interceptor.dart';
import 'cache.dart';
import 'connectivity_request_retrier.dart';
import 'error_interceptor.dart';
import 'global.dart';
// import 'net_cache.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class Http {
  ///超时时间15秒
  static const int CONNECT_TIMEOUT = 15000;
  static const int RECEIVE_TIMEOUT = 15000;

  static Http _instance = Http._internal();

  factory Http() => _instance;

  Dio? dio;
  CancelToken _cancelToken = new CancelToken();

  Http._internal() {
    if (dio == null) {
      // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
      BaseOptions options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: RECEIVE_TIMEOUT,
        // Http请求头.
        headers: {},
      );

      dio = new Dio(options);

      // 添加拦截器
      dio!.interceptors.add(ErrorInterceptor());
      // 加内存缓存
//      dio!.interceptors.add(NetCacheInterceptor());
      if (Global.retryEnable) {
        dio!.interceptors.add(
          RetryOnConnectionChangeInterceptor(
            requestRetrier: DioConnectivityRequestRetrier(
              dio: dio,
              connectivity: Connectivity(),
            ),
          ),
        );
      }
      dio!.interceptors.add(LogInterceptor());

      // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
      if (PROXY_ENABLE) {
        (dio!.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.findProxy = (uri) {
            return "PROXY $PROXY_IP:$PROXY_PORT";
          };
          //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        };
      }
    }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {required String baseUrl,
      required int connectTimeout,
      required int receiveTimeout,
      List<Interceptor>? interceptors}) {
    // dio.options = dio.options.merge(
    //   baseUrl: baseUrl,
    //   connectTimeout: connectTimeout,
    //   receiveTimeout: receiveTimeout,
    // );
    dio!.options.baseUrl = baseUrl;
    dio!.options.connectTimeout = connectTimeout;
    dio!.options.receiveTimeout = receiveTimeout;
    if (interceptors != null && interceptors.isNotEmpty) {
      dio!.interceptors.addAll(interceptors);
    }
  }

  /// 设置headers
  void setHeaders(Map<String, dynamic> map) {
    dio!.options.headers.addAll(map);
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }

  /// 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers;
    // String accessToken = Global.accessToken ?? '';
    String accessToken = AppManager.currentToken ?? '';

    headers = {"Authorization": 'Bearer $accessToken'};
    return headers;
  }

  /// restful get 操作
  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    String? cacheKey,
    bool cacheDisk = false,
  }) async {
    Dio _dio = Dio();
    Options requestOptions = options ?? Options();
    requestOptions.extra = {
      "refresh": refresh,
      "noCache": noCache,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    };
    // requestOptions = requestOptions.merge(extra: {
    //   "refresh": refresh,
    //   "noCache": noCache,
    //   "cacheKey": cacheKey,
    //   "cacheDisk": cacheDisk,
    // });
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      // requestOptions = requestOptions.merge(headers: _authorization);
      requestOptions.headers = _authorization;
    }
    Response response;
    response = await _dio.get(HttpApi.baseUrl + path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions.headers = _authorization;
      logD('post请求header: ${requestOptions.headers}');
    }
    var response = await dio!.post(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful put 操作
  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      // requestOptions = requestOptions.merge(headers: _authorization);
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio!.put(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      // requestOptions = requestOptions.merge(headers: _authorization);
//      requestOptions = requestOptions.copyWith(headers: _authorization);
      requestOptions.headers = _authorization;
    }
    var response = await dio!.patch(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      // requestOptions = requestOptions.merge(headers: _authorization);
//      requestOptions = requestOptions.copyWith(headers: _authorization);
      requestOptions.headers = _authorization;
    }
    var response = await dio!.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    required Map<String, dynamic> params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      // requestOptions = requestOptions.merge(headers: _authorization);
//      requestOptions = requestOptions.copyWith(headers: _authorization);
      requestOptions.headers = _authorization;
    }
    var response = await dio!.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }
}
