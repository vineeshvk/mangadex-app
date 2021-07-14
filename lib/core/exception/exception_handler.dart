import 'package:dio/dio.dart';

import '../../models/responses/base_response.dart';
import '../../models/responses/common/error_response.dart';
import 'api_exception.dart';
import 'cache_exception.dart';

typedef Operation<T> = Future<T> Function();

class ExceptionHandler {
  ExceptionHandler._();

  static Future<T> api<T>(Operation<T> operation) async {
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

  /// Takes an api `[operation]` and an optional cache operation `[cacheOp]`;
  /// `dart[cacheOp]` will be executed first and if the data is not null then it will be returned;
  /// And if it is null only then the api operation will be executed
  static Future<BaseResponse<T>> repo<T>(
    Operation<T> operation, {
    Operation<T>? cacheOp,
  }) async {
    BaseResponse<T>? response;

    if (cacheOp != null) {
      try {
        final result = await cacheOp();
        if (result != null) {
          response = BaseResponse(response: result);
        }
      } on CacheException catch (_) {/* */}
    }

    if (response != null) return response;

    try {
      final result = await operation();
      response = BaseResponse(response: result);
    } on ApiException catch (exception) {
      response = BaseResponse(error: exception.error);
    }

    return response;
  }
}
