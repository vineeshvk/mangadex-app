import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/manga_constants.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/manga/chapter_remote_data_source.dart';
import 'package:mangadex/models/common/base_item_model.dart';
import 'package:mangadex/models/manga/chapter_item_model.dart';
import 'package:mangadex/models/master/chapter_master_model.dart';
import 'package:mangadex/models/params/manga/chapter_list_params.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/models/responses/common/data_response.dart';
import 'package:mangadex/models/responses/manga/chapter_list_response.dart';
import 'package:mangadex/repositories/manga/chapter_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/utils.dart/test_util.dart';

typedef ChapterItemResponse = DataResponse<BaseItemModel<ChapterItemModel>>;

class MockChapterDataSource extends Mock implements ChapterRemoteDataSource {}

class ChapterParamsFake extends Fake implements ChapterListParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(ChapterParamsFake());
  });

  final dataSource = MockChapterDataSource();
  final chapterRepo = ChapterRepository(chapterDataSource: dataSource);

  final chapterListRes = ChapterListResponse(results: [
    ChapterItemResponse(
      result: "ok",
      data: BaseItemModel(
        id: "12345",
        attributes: ChapterItemModel(
          title: "first chapter",
          volume: "volume",
          chapter: "chapter",
          hash: "hash",
        )..id = "12345",
        type: MangaRelationshipTypes.chapter,
      ),
    )
  ]);

  group("Chapter repo", () {
    test("get chapter list", () async {
      when(() => dataSource.getChapterList(any()))
          .thenAnswer((_) async => chapterListRes);

      expect(
        await chapterRepo.getChapterList(ChapterListParams(mangaId: "54321")),
        isA<BaseResponse<List<ChapterMasterModel>>>()
            .having((res) => res.data, "chapter list", isNotEmpty)
            .having(
              (res) => res.data?.first.title,
              "chapter title",
              "first chapter",
            ),
      );

      when(() => dataSource.getChapterList(any())).thenThrow(ApiException());

      expect(
        await chapterRepo.getChapterList(ChapterListParams(mangaId: "54321")),
        TestUtil.checkError(isA<BaseResponse<List<ChapterMasterModel>>>()),
      );
    });
  });
}
