import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data/data_sourcers/manga/manga_data_source.dart';
import 'package:mangadex/http/http_urls.dart';
import 'package:mangadex/http/responses/manga/manga_list_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final dio = DioMock(BaseOptions(baseUrl: HttpConstants.baseUrl)).dio;

  final dioAdapter = DioAdapter();
  dio.httpClientAdapter = dioAdapter;

  final mangaDataSource = MangaDataSource(dio: dio);

  group("Get manga list api", () {
    test("Success", () async {
      dioAdapter.onGet(HttpUrls.manga, (request) {
        request.reply(200, Fixtures.parse(Fixtures.mangaList), headers: {
          Headers.acceptHeader: ["application/json"]
        });
      });

      expect(
        await mangaDataSource.getMangaList(),
        isA<MangaListResponse>(),
      );
    });

    test("Failure", () async {
      dioAdapter.onGet(HttpUrls.manga, (request) {
        request.reply(204, Fixtures.parse(Fixtures.error), headers: {
          Headers.acceptHeader: ["application/json"]
        });
      });

      expect(
        () => mangaDataSource.getMangaList(),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
