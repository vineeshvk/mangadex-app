import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/features/chapter_list/cubit/chapter_list_cubit.dart';
import 'package:mangadex/models/master/chapter_master_model.dart';
import 'package:mangadex/models/master/manga_master_model.dart';
import 'package:mangadex/models/params/manga/chapter_list_params.dart';
import 'package:mangadex/models/responses/base_response.dart';
import 'package:mangadex/repositories/manga/chapter_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockChapterRepository extends Mock implements ChapterRepository {}

class ChapterParamsFake extends Fake implements ChapterListParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(ChapterParamsFake());
  });

  final chapterRepo = MockChapterRepository();
  final manga = MangaMasterModel(
    originalLanguage: '',
    tags: [],
    title: '',
    id: "1",
  );
  group("ChapterListCubit", () {
    init(chapterRepo, manga);
  });
}

void init(ChapterRepository chapterRepo, MangaMasterModel manga) {
  final successRes = BaseResponse(data: [
    ChapterMasterModel(
      title: "chapter title",
      volume: "2",
      chapter: "12",
    )
  ]);
  group("init logic test", () {
    blocTest<ChapterListCubit, ChapterListState>(
      "on success response",
      build: () => ChapterListCubit(
        chapterRepository: chapterRepo,
        manga: manga,
      ),
      act: (cubit) {
        when(() => chapterRepo.getChapterList(any()))
            .thenAnswer((_) async => successRes);
        cubit.init();
      },
      expect: () => [ChapterListLoadingState(), ChapterListLoadedState()],
      verify: (cubit) {
        expect(cubit.manga.chapters, isNotEmpty);
        expect(cubit.manga.chapters.first.volume, "2");
      },
    );
  });
}
