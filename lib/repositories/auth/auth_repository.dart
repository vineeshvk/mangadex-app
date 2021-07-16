import '../../core/exception/exception_handler.dart';
import '../../data_sources/remote_data/auth/auth_remote_data_source.dart';
import '../../models/auth/token_model.dart';
import '../../models/responses/auth/token_response.dart';
import '../../models/responses/base_response.dart';

class AuthRepository {
  AuthRemoteDataSource authDataSource;

  AuthRepository({
    required this.authDataSource,
  });

  Future<BaseResponse<TokenModel>> login({
    required String username,
    required String password,
  }) {
    return ExceptionHandler.repo(() async {
      final TokenResponse tokenResponse = await authDataSource.login(
        username: username,
        password: password,
      );

      return BaseResponse(data: tokenResponse.token);
    });
  }
}
