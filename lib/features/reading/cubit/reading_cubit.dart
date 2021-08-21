import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mangadex/models/master/chapter_master_model.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/manga_master_model.dart';

part 'reading_state.dart';

class ReadingCubit extends Cubit<ReadingState> {
  //constants
  final MangaMasterModel manga;
  late PageController pageController;

  // states
  ChapterMasterModel currentChapter;
  int currentPageIndex = 0;

  ReadingCubit({required this.manga, required this.currentChapter})
      : super(ReadingIdleState());

  void init() {
    final pageIndex = manga.chapterPresenter
        .indexWhere((element) => element.ofChapter == currentChapter);

    pageController = PageController(initialPage: pageIndex);
  }

  void onPageChange(int page) {
    currentPageIndex = page;

    if (manga.chapterPresenter[page].ofChapter != null) {
      currentChapter = manga.chapterPresenter[page].ofChapter!;
    }

    emit(ReadingChapterChangedState(currentChapter));
  }

  void changeChapter(ChapterMasterModel? chapter) {
    if (chapter != null) {
      currentChapter = chapter;
    }

    final pageIndex = manga.chapterPresenter.indexWhere(
      (element) => element.ofChapter == currentChapter,
    );

    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 600),
      curve: Curves.ease,
    );

    emit(ReadingChapterChangedState(currentChapter));
  }
}
