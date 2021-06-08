import '../../core/exception/exception_handler.dart';
import '../../data_sources/auth/auth_data_source.dart';
import '../../models/responses/auth/token_response.dart';
import '../../models/responses/base_response.dart';

class AuthRepository {
  AuthDataSource authDataSource;

  AuthRepository({
    required this.authDataSource,
  });

  Future<BaseResponse<TokenResponse>> login({
    required String username,
    required String password,
  }) {
    return ExceptionHandler.repo(() async {
      final TokenResponse token = await authDataSource.login(
        username: username,
        password: password,
      );

      return token;
    });
  }
}
