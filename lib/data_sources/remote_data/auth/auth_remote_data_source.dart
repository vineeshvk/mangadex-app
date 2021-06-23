import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../models/responses/auth/token_response.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<TokenResponse> login({
    required String username,
    required String password,
  }) {
    return ExceptionHandler.api(() async {
      final Response response = await dio.post(
        HttpUrls.login,
        data: {"username": username, "password": password},
      );

      return TokenResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }
}
