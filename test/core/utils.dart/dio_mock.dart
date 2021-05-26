import 'dart:convert';

import 'package:dio/dio.dart';

class DioMock {
  late final Dio dio;

  DioMock([BaseOptions? options, bool enableLog = false]) {
    dio = Dio(options);
    // dio.options.headers[HttpHeaders.acceptHeader] = Headers.jsonContentType;
    dio.options.followRedirects = true;
    dio.options.validateStatus = (status) => status! <= 400;

    _setupAuthInterceptor();

    if (enableLog) _setupLogInterceptor();
  }

  void _setupAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        handler.next(options);
      }, onResponse: (response, handler) {
        response.data = jsonDecode(response.data.toString()) as Map;

        handler.next(response);
      }),
    );
  }

  void _setupLogInterceptor() {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
