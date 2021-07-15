import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/auth/auth_remote_data_source.dart';
import 'package:mangadex/models/auth/token_model.dart';
import 'package:mangadex/models/responses/auth/token_response.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/repositories/auth/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/utils.dart/test_util.dart';

class MockAuthDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  final dataSource = MockAuthDataSource();
  final authRepo = AuthRepository(authDataSource: dataSource);

  group("Auth repo", () {
    test("login", () async {
      when(() => dataSource.login(
          username: any(named: "username"),
          password: any(named: "password"))).thenAnswer(
        (_) async => TokenResponse(
          result: "ok",
          token: TokenModel(refresh: "refresh_token", session: "session_token"),
        ),
      );

      expect(
        await authRepo.login(username: "admin", password: "admin"),
        isA<BaseResponse<TokenResponse>>()
            .having((res) => res.hasData, "token", true)
            .having(
              (res) => res.data?.token.session,
              "session",
              "session_token",
            ),
      );

      when(
        () => dataSource.login(
          username: any(named: "username"),
          password: any(named: "password"),
        ),
      ).thenThrow(ApiException());

      expect(
        await authRepo.login(username: "admin", password: "admin"),
        TestUtil.checkError(isA<BaseResponse<TokenResponse>>()),
      );
    });
  });
}
