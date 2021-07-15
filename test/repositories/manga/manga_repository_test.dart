import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/manga_constants.dart';
import 'package:mangadex/core/exception/api_exception.dart';
import 'package:mangadex/data_sources/remote_data/manga/manga_remote_data_source.dart';
import 'package:mangadex/models/common/base_item_model.dart';
import 'package:mangadex/models/common/label_model.dart';
import 'package:mangadex/models/manga/manga_item_model.dart';
import 'package:mangadex/models/manga/tag_model.dart';
import 'package:mangadex/models/master/manga_master_model.dart';
import 'package:mangadex/models/master/tag_master_model.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/models/responses/common/data_response.dart';
import 'package:mangadex/models/responses/manga/manga_list_response.dart';
import 'package:mangadex/models/responses/manga/tag_list_response.dart';
import 'package:mangadex/repositories/manga/manga_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/utils.dart/test_util.dart';

class MockMangaDataSource extends Mock implements MangaRemoteDataSource {}

void main() {
  final dataSource = MockMangaDataSource();
  final mangaRepo = MangaRepository(mangaDataSource: dataSource);

  final mangaListRes = MangaListResponse(results: [
    DataResponse(
      result: "ok",
      data: BaseItemModel(
          attributes: MangaItemModel(
            createdAt: '',
            updatedAt: '',
            originalLanguage: 'japanese',
            title: LabelModel(en: "sample manga"),
            description: LabelModel(en: "desc"),
          ),
          id: '1',
          type: MangaRelationshipTypes.manga),
    )
  ]);

  final taglistRes = TagListResponse(tags: [
    DataResponse(
      result: "ok",
      data: BaseItemModel(
        id: "1",
        type: MangaRelationshipTypes.tag,
        attributes: TagModel(
          group: "p",
          name: LabelModel(en: "action"),
          version: 1,
        ),
      ),
    )
  ]);

  group("Manga repo", () {
    test("get manga list", () async {
      when(() => dataSource.getMangaList(any()))
          .thenAnswer((_) async => mangaListRes);

      expect(
        await mangaRepo.getMangaList(),
        isA<BaseResponse<List<MangaMasterModel>>>()
            .having((res) => res.data, "manga list", isNotEmpty)
            .having(
              (res) => res.data?.first.title,
              "title",
              "sample manga",
            ),
      );

      when(() => dataSource.getMangaList(any())).thenThrow(ApiException());

      expect(
        await mangaRepo.getMangaList(),
        TestUtil.checkError(isA<BaseResponse<List<MangaMasterModel>>>()),
      );
    });

    test("get tag list", () async {
      when(() => dataSource.getTagList()).thenAnswer((_) async => taglistRes);

      expect(
        await mangaRepo.getTagList(),
        isA<BaseResponse<List<TagMasterModel>>>()
            .having((res) => res.data, "tag list", isNotEmpty)
            .having(
              (res) => res.data?.first.name,
              "tag name",
              "action",
            ),
      );

      when(() => dataSource.getTagList()).thenThrow(ApiException());

      expect(
        await mangaRepo.getTagList(),
        TestUtil.checkError(isA<BaseResponse<List<TagMasterModel>>>()),
      );
    });
  });
}
