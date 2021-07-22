import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/constants/http_urls.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/manga/chapter_remote_data_source.dart';
import 'package:mangadex/models/params/manga/chapter_list_params.dart';
import 'package:mangadex/models/responses/common/data_response.dart';
import 'package:mangadex/models/responses/manga/chapter_list_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final DioMock dioMock = DioMock(
    options: BaseOptions(baseUrl: HttpConstants.baseUrl),
  );

  final chapterDataSource = ChapterRemoteDataSource(networkClient: dioMock.dio);
  group("Chapter read & unread api", () {
    test("200 status chapter read", () async {
      dioMock.adapter.onPost(HttpUrls.chapterRead("uuid"), (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.status),
        );
      });

      expect(
        await chapterDataSource.markChapterRead("uuid"),
        isA<DataResponse>().having(
          (res) => res.result,
          "result",
          equals("ok"),
        ),
      );
    });

    test("200 status chapter unread", () async {
      dioMock.adapter.onDelete(HttpUrls.chapterRead("uuid"), (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.status),
        );
      });

      expect(
        await chapterDataSource.markChapterUnRead("uuid"),
        isA<DataResponse>().having(
          (res) => res.result,
          "result",
          equals("ok"),
        ),
      );
    });
  });

  group("Get chapter list api", () {
    final params = ChapterListParams(mangaId: "mangaId");
    test("200 status", () async {
      dioMock.adapter.onGet(
        HttpUrls.chapters("mangaId"),
        (request) {
          request.reply(200, Fixtures.parse(Fixtures.chapterList));
        },
        queryParameters: params.toJson(),
      );

      expect(
        await chapterDataSource.getChapterList(params),
        isA<ChapterListResponse>()
            .having(
              (res) => res.results,
              "chapter list",
              isNotEmpty,
            )
            .having(
              (res) => res.results.first.data.attributes.id,
              "chapter id",
              isNotNull,
            ),
      );
    });

    test("400 status", () async {
      dioMock.adapter.onGet(HttpUrls.chapters("mangaId"), (request) {
        request.throws(
          400,
          DioError(
            requestOptions: RequestOptions(path: HttpUrls.chapters("mangaId")),
            error: Fixtures.parse(Fixtures.error),
          ),
        );
      }, queryParameters: params.toJson());

      expect(
        () => chapterDataSource.getChapterList(params),
        throwsA(isA<ApiException>().having((e) => e.error, "error", isNotNull)),
      );
    });
  });
}
