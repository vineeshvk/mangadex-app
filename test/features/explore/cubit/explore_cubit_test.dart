import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/core/constants/string_constants.dart';
import 'package:mangadex/features/explore/cubit/explore_cubit.dart';
import 'package:mangadex/models/common/error_model.dart';
import 'package:mangadex/models/master/manga_master_model.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/models/responses/common/error_response.dart';
import 'package:mangadex/repositories/manga/manga_repository.dart';
import 'package:mocktail/mocktail.dart';

typedef MangaBaseResponse = BaseResponse<List<MangaMasterModel>>;

class MockMangaRepository extends Mock implements MangaRepository {}

void main() {
  final MangaRepository repo = MockMangaRepository();
  final cubit = ExploreCubit(mangaRepository: repo);

  group("ExploreCubit tests", () {
    initTest(repo, cubit);
  });
}

void initTest(MangaRepository repo, ExploreCubit cubit) {
  final successResponse = MangaBaseResponse(response: [
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
      build: () => cubit,
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
  });
}
