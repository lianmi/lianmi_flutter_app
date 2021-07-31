// import 'package:linkme_flutter_sdk/util/common/common_header.dart';
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioConnectivityRequestRetrier {
  final Dio? dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      Options _op = requestOptions as Options;
      streamSubscription = connectivity.onConnectivityChanged.listen(
        (connectivityResult) {
          if (connectivityResult != ConnectivityResult.none) {
            streamSubscription.cancel();
            responseCompleter.complete(
              dio!.request(
                requestOptions.path,
                cancelToken: requestOptions.cancelToken,
                data: requestOptions.data,
                onReceiveProgress: requestOptions.onReceiveProgress,
                onSendProgress: requestOptions.onSendProgress,
                queryParameters: requestOptions.queryParameters,
                // options: requestOptions,
                options: _op,
              ),
            );
          }
        },
      );
    });
    return responseCompleter.future;
  }
}
