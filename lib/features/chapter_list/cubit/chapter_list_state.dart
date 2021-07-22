part of 'chapter_list_cubit.dart';

abstract class ChapterListState extends BaseEquatable {}

class ChapterListIdleState extends ChapterListState {}

class ChapterListLoadingState extends ChapterListState {}

class ChapterListLoadedState extends ChapterListState {}

class ChapterListErrorState extends ChapterListState {
  final String? message;

  ChapterListErrorState(this.message);
}
