import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/constants/http_urls.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data/remote_data/manga/manga_remote_data_source.dart';
import 'package:mangadex/models/responses/manga/manga_list_response.dart';
import 'package:mangadex/models/responses/manga/tag_list_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final DioMock dioMock = DioMock(
    options: BaseOptions(baseUrl: HttpConstants.baseUrl),
  );

  final mangaDataSource = MangaRemoteDataSource(dio: dioMock.dio);

  group("Get manga list api", () {
    test("200 status", () async {
      dioMock.adapter.onGet(HttpUrls.manga, (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.mangaList),
          headers: dioMock.acceptedHeaders,
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
          headers: dioMock.acceptedHeaders,
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
}
