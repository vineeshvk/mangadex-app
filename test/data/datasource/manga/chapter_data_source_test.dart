import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/http_constants.dart';
import 'package:mangadex/core/constants/http_urls.dart';
import 'package:mangadex/data/remote_data/manga/chapter_remote_data_source.dart';
import 'package:mangadex/data_sources/manga/chapter_data_source.dart';
import 'package:mangadex/models/responses/common/base_data_response.dart';

import '../../../core/utils.dart/dio_mock.dart';
import '../../../fixtures/fixtures_reader.dart';

void main() {
  final DioMock dioMock = DioMock(
    options: BaseOptions(baseUrl: HttpConstants.baseUrl),
  );

  final ChapterDataSource chapterDataSource =
      ChapterRemoteDataSource(dio: dioMock.dio);
  group("Chapter read & unread api", () {
    test("200 status chapter read", () async {
      dioMock.adapter.onPost(HttpUrls.chapterRead("uuid"), (request) {
        request.reply(
          200,
          Fixtures.parse(Fixtures.status),
          headers: dioMock.acceptedHeaders,
        );
      });

      expect(
        await chapterDataSource.markChapterRead("uuid"),
        isA<BaseDataResponse>().having(
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
          headers: dioMock.acceptedHeaders,
        );
      });

      expect(
        await chapterDataSource.markChapterUnRead("uuid"),
        isA<BaseDataResponse>().having(
          (res) => res.result,
          "result",
          equals("ok"),
        ),
      );
    });
  });
}