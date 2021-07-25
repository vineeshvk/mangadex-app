import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';

import '../constants/http_constants.dart';

class DioUtil {
  Dio dio = Dio();

  DioUtil() {
    dio.options.baseUrl = HttpConstants.baseUrl;
    dio.options.followRedirects = true;
    dio.options.headers[HttpHeaders.acceptHeader] = "application/json";
    dio.options.validateStatus = (status) => status! <= 400;
    dio.transformer = JsonTransformer();

    //setup auth interceptor
    _setupAuthInterceptor();
    //setup log interceptor
    _setupLogInterceptor();
    // _setupCacheInterceptor();
  }

  void _setupAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(),
    );
  }

  void _setupLogInterceptor() {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  void _setupCacheInterceptor() {
    final intercptor = DioCacheManager(CacheConfig(
            baseUrl: HttpConstants.baseUrl,
            defaultMaxAge: const Duration(seconds: 5)))
        .interceptor;
    dio.interceptors.add(intercptor as Interceptor);
  }
}

//This transformer runs the json decoding in a background thread.
//Thus returing a Future of Map
class JsonTransformer extends DefaultTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _parseJson);
}

Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}
