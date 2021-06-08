import '../../models/responses/auth/token_response.dart';

abstract class AuthDataSource {
  Future<TokenResponse> login({
    required String username,
    required String password,
  });
}
