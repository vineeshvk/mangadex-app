import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/manga_constants.dart';
import 'package:mangadex/core/constants/string_constants.dart';
import 'package:mangadex/features/explore/cubit/explore_cubit.dart';
import 'package:mangadex/models/common/error_model.dart';
import 'package:mangadex/models/master/manga_master_model.dart';
import 'package:mangadex/models/master/tag_master_model.dart';
import 'package:mangadex/models/params/manga/manga_list_params.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/models/responses/common/error_response.dart';
import 'package:mangadex/models/responses/common/pagination_handler.dart';
import 'package:mangadex/repositories/manga/manga_repository.dart';
import 'package:mocktail/mocktail.dart';

typedef MangaBaseResponse = BaseResponse<List<MangaMasterModel>>;
typedef TagBaseResponse = BaseResponse<List<TagMasterModel>>;

class MockMangaRepository extends Mock implements MangaRepository {}

class MockPagination with PaginationHandler {}

void main() {
  final MangaRepository repo = MockMangaRepository();

  final successResponse = TagBaseResponse(
    data: [TagMasterModel(id: "1", name: "action", group: "genre")],
  );
  when(() => repo.getTagList()).thenAnswer((_) async => successResponse);

  group("ExploreCubit", () {
    initTest(repo);
    searchMangaTest(repo);
    changeFilterValueTest(repo);
    fetchMoreManga(repo);
  });
}

void initTest(MangaRepository repo) {
  final successResponse = MangaBaseResponse(data: [
    MangaMasterModel(
      title: "hello",
      tags: ["shonen"],
      originalLanguage: "japan",
    )
  ]);

  final failureResponse = MangaBaseResponse(
    error: ErrorResponse(result: "failure", errors: [
      ErrorModel(id: "id", status: 0, title: "error", detail: "network")
    ]),
  );

  group('init logic tests', () {
    blocTest<ExploreCubit, ExploreState>(
      'on success response',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) {
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => successResponse);
        cubit.init();
      },
      expect: () => [ExploreLoadingState(), ExploreMangaListLoadedState()],
      verify: (cubit) => expect(cubit.mangaList, isNotEmpty),
    );

    blocTest<ExploreCubit, ExploreState>(
      'on failure response',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) {
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => failureResponse);
        cubit.init();
      },
      expect: () => [ExploreLoadingState(), ExploreFailureState("error")],
    );

    blocTest<ExploreCubit, ExploreState>(
      'on unknown failure response',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) {
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => MangaBaseResponse());
        cubit.init();
      },
      expect: () => [
        ExploreLoadingState(),
        ExploreFailureState(StringConstants.somethingWentWrong)
      ],
    );

    fetchingTagTest(repo);
  });
}

void fetchingTagTest(MangaRepository repo) {
  group(
    "fetching tags",
    () {
      blocTest<ExploreCubit, ExploreState>(
        "on success",
        build: () => ExploreCubit(mangaRepository: repo),
        act: (cubit) async {
          await cubit.init();
        },
        verify: (cubit) {
          expect(cubit.tagList, isNotEmpty);
          expect(cubit.tagList.first.name, "action");
        },
      );
    },
  );
}

void searchMangaTest(MangaRepository repo) {
  final successResponse = MangaBaseResponse(data: [
    MangaMasterModel(
      title: "hello",
      tags: ["shonen"],
      originalLanguage: "japan",
    )
  ]);

  final failureResponse = MangaBaseResponse(
    error: ErrorResponse(result: "failure", errors: [
      ErrorModel(id: "id", status: 0, title: "error", detail: "network")
    ]),
  );

  group('searchManga logic tests', () {
    blocTest<ExploreCubit, ExploreState>(
      'on success response',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) async {
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => successResponse);
        await cubit.init();
        await cubit.searchManga();
      },
      expect: () => [
        ExploreLoadingState(),
        ExploreMangaListLoadedState(),
        ExploreLoadingState(),
        ExploreMangaListLoadedState()
      ],
      verify: (cubit) => expect(cubit.mangaList, isNotEmpty),
    );

    blocTest<ExploreCubit, ExploreState>(
      'on failure response',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) async {
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => failureResponse);
        await cubit.init();
        await cubit.searchManga();
      },
      verify: (cubit) => expect(cubit.mangaList, isEmpty),
    );
  });
}

void changeFilterValueTest(MangaRepository repo) {
  group("changeFilterValue logic test", () {
    blocTest<ExploreCubit, ExploreState>(
      'on filter change',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) async {
        await cubit.init();
        cubit.changeFilterValue(MangaParamType.includedTags, "mystery");
      },
      verify: (cubit) {
        expect(cubit.mangaListParams.includedTags, ["mystery"]);

        cubit.changeFilterValue(MangaParamType.includedTags, "mystery");
        expect(cubit.mangaListParams.includedTags, isNull);

        cubit.changeFilterValue(MangaParamType.status, MangaStatus.completed);
        expect(cubit.mangaListParams.status, [MangaStatus.completed]);

        cubit.changeFilterValue(MangaParamType.status, MangaStatus.completed);
        expect(cubit.mangaListParams.status, isNull);

        cubit.changeFilterValue(MangaParamType.createdAt, null);
        expect(cubit.mangaListParams.createdAt, OrderBy.desc);
      },
    );
  });
}

void fetchMoreManga(MangaRepository repo) {
  final successResponse = MangaBaseResponse(
    data: [
      MangaMasterModel(
        title: "hello",
        tags: ["shonen"],
        originalLanguage: "japan",
      )
    ],
  );

  group("fetchMoreManga logic test", () {
    blocTest<ExploreCubit, ExploreState>(
      'on filter change',
      build: () => ExploreCubit(mangaRepository: repo),
      act: (cubit) async {
        successResponse.pagination = MockPagination()
          ..limit = 1
          ..offset = 0
          ..total = 2;
        when(() => repo.getMangaList(any()))
            .thenAnswer((_) async => successResponse);
        await cubit.init();
        cubit.changeFilterValue(MangaParamType.includedTags, "mystery");

        successResponse.pagination = MockPagination()
          ..limit = 1
          ..offset = 1
          ..total = 2;
        await cubit.fetchMoreManga();
      },
      verify: (cubit) async {
        expect(cubit.mangaList.length, 2);

        // it's on last page. So shouldn't fetch more.
        await cubit.fetchMoreManga();
        expect(cubit.mangaList.length, 2);
      },
    );
  });
}
