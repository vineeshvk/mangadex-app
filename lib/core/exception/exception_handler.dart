import 'package:dio/dio.dart';

import '../../models/responses/base_response.dart';
import '../../models/responses/common/error_response.dart';
import 'api_exception.dart';

class ExceptionHandler {
  ExceptionHandler._();

  static Future<T> api<T>(Future<T> Function() operation) async {
    try {
      final T result = await operation();
      return result;
    } on DioError catch (dioError) {
      final error = dioError.error as Map<String, dynamic>?;

      throw ApiException(
        error: error != null ? ErrorResponse.fromJson(error) : null,
      );
    } catch (e) {
      throw ApiException();
    }
  }

  static Future<BaseResponse<T>> repo<T>(Future<T> Function() operation) async {
    BaseResponse<T> response;
    try {
      final result = await operation();
      response = BaseResponse(response: result);
    } on ApiException catch (exception) {
      response = BaseResponse(error: exception.error);
    }

    return response;
  }
}
