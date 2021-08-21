part of 'reading_cubit.dart';

abstract class ReadingState extends BaseEquatable {}

class ReadingIdleState extends ReadingState {}

class ReadingChapterChangedState extends ReadingState {
  final ChapterMasterModel chapter;

  ReadingChapterChangedState(this.chapter);

  @override
  List<Object?> get props => [chapter];
}
