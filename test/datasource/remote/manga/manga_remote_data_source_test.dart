import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/constants/http_urls.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/manga/manga_remote_data_source.dart';
import 'package:mangadex/models/responses/manga/manga_list_response.dart';
import 'package:mangadex/models/responses/manga/tag_list_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final DioMock dioMock = DioMock(
    options: BaseOptions(baseUrl: HttpConstants.baseUrl),
  );

  final mangaDataSource = MangaRemoteDataSource(networkClient: dioMock.dio);

  group("Get manga list api", () {
    test("200 status", () async {
      dioMock.adapter.onGet(HttpUrls.manga, (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.mangaList),
        );
      });

      expect(
        await mangaDataSource.getMangaList(),
        isA<MangaListResponse>().having(
          (res) => res.results,
          "results",
          isNotEmpty,
        ),
      );
    });

    test("400 status", () async {
      dioMock.adapter.onGet(HttpUrls.manga, (request) {
        request.throws(
          400,
          DioError(
            requestOptions: RequestOptions(path: HttpUrls.manga),
            error: Fixtures.parse(Fixtures.error),
          ),
        );
      });

      expect(
        () => mangaDataSource.getMangaList(),
        throwsA(isA<ApiException>().having((e) => e.error, "error", isNotNull)),
      );
    });
  });

  group("Get tag list api", () {
    test("200 status", () async {
      dioMock.adapter.onGet(HttpUrls.tags, (request) {
        request.reply(
          200,
          Fixtures.parseList(Fixtures.tagList),
        );
      });
      expect(
        await mangaDataSource.getTagList(),
        isA<TagListResponse>().having(
          (res) => res.tags,
          "tags",
          isNotEmpty,
        ),
      );
    });
  });

  group("Get Cover api", () {
    test("200 status", () async {
      dioMock.adapter.onGet(HttpUrls.cover("1"), (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.cover),
        );
      });
      expect(
        await mangaDataSource.getCover("1"),
        isA<CoverResponse>().having(
          (res) => res.data.attributes,
          "cover",
          isNotNull,
        ),
      );
    });

    test("400/403/404 status", () async {
      dioMock.adapter.onGet(HttpUrls.cover("1"), (request) {
        request.throws(
          400,
          DioError(
            requestOptions: RequestOptions(path: HttpUrls.cover("1")),
            error: Fixtures.parse(Fixtures.error),
          ),
        );
      });

      expect(
        () => mangaDataSource.getCover("1"),
        throwsA(isA<ApiException>().having((e) => e.error, "error", isNotNull)),
      );
    });
  });
}
