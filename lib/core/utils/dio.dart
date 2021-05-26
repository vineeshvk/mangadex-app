import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/http_constants.dart';

final Dio dio = DioHelper().dio;

class DioHelper {
  Dio dio = Dio();

  DioHelper() {
    dio.options.baseUrl = HttpConstants.baseUrl;
    dio.options.followRedirects = true;
    dio.options.headers[HttpHeaders.acceptHeader] = "application/json";
    dio.options.validateStatus = (status) => status! <= 400;
    dio.transformer = JsonTransformer();

    //setup auth interceptor
    _setupAuthInterceptor();
    //setup log interceptor
    _setupLogInterceptor();
  }

  void _setupAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(),
    );
  }

  void _setupLogInterceptor() {
    dio.interceptors.add(LogInterceptor(responseBody: true));
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
