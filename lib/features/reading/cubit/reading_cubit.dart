import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/chapter_master_model.dart';
import '../../../models/master/manga_master_model.dart';

part 'reading_state.dart';

class ReadingCubit extends Cubit<ReadingState> {
  //constants
  final MangaMasterModel manga;
  final PageController pageController = PageController(initialPage: 2);

  // states
  int chapterIndex;
  int pageNumber = 0;

  ReadingCubit({required this.manga, required this.chapterIndex})
      : super(ReadingIdleState());

  bool get hasPrevious => chapterIndex > 0;
  bool get hasNext => chapterIndex < manga.chapters.length - 1;
  ChapterMasterModel get currentChapter => manga.chapters[chapterIndex];

  void init() {}

  void nextChapter() {
    chapterIndex++;
    emit(ReadingChapterChangedState(chapterIndex));
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
  }

  void previousChapter() {
    chapterIndex--;
    emit(ReadingChapterChangedState(chapterIndex));
    pageController.animateToPage(currentChapter.pages.length + 1,
        duration: const Duration(microseconds: 1), curve: Curves.linear);
  }
}
