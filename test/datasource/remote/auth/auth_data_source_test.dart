import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/constants/http_urls.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/auth/auth_remote_data_source.dart';
import 'package:mangadex/models/responses/auth/token_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final DioMock dioMock = DioMock(
    options: BaseOptions(baseUrl: HttpConstants.baseUrl),
  );

  final authDataSource = AuthRemoteDataSource(dio: dioMock.dio);
  final Map<String, String> data = {"username": "demo", "password": "demo"};

  group("login api", () {
    test("200 status", () async {
      dioMock.adapter.onPost(HttpUrls.login, (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.token),
        );
      }, data: data);

      final result =
          await authDataSource.login(username: "demo", password: "demo");
      expect(
        result,
        isA<TokenResponse>().having(
          (res) => res.result,
          "result",
          equals("ok"),
        ),
      );
    });

    test("400 status", () async {
      dioMock.adapter.onPost(HttpUrls.login, (request) {
        request.throws(
          400,
          DioError(
            requestOptions: RequestOptions(path: HttpUrls.login),
            error: Fixtures.parse(Fixtures.error),
          ),
        );
      }, data: data);

      expect(
        () => authDataSource.login(username: "demo", password: "demo"),
        throwsA(isA<ApiException>().having((e) => e.error, "error", isNotNull)),
      );
    });
  });
}
