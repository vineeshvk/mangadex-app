part of 'reading_cubit.dart';

abstract class ReadingState extends BaseEquatable {}

class ReadingIdleState extends ReadingState {}

class ReadingChapterChangedState extends ReadingState {
  final int chapterIndex;

  ReadingChapterChangedState(this.chapterIndex);

  @override
  List<Object?> get props => [chapterIndex];
}
