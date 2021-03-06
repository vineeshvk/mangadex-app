import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class DioMock {
  late final Dio dio;
  late final DioAdapter adapter;

  final acceptedHeaders = {
    Headers.acceptHeader: ["application/json"]
  };

  DioMock({BaseOptions? options, bool enableLog = false}) {
    dio = Dio(options);
    // dio.options.headers[HttpHeaders.acceptHeader] = Headers.jsonContentType;
    dio.options.followRedirects = true;
    dio.options.validateStatus = (status) => status! <= 400;

    adapter = DioAdapter(dio: Dio());
    dio.httpClientAdapter = adapter;

    _setupAuthInterceptor();

    if (enableLog) _setupLogInterceptor();
  }

  void _setupAuthInterceptor() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        handler.next(options);
      }),
    );
  }

  void _setupLogInterceptor() {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
