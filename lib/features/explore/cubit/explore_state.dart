part of 'explore_cubit.dart';

abstract class ExploreState extends BaseEquatable {}

class ExploreIdleState extends ExploreState {}

class ExploreLoadingState extends ExploreState {}

class ExploreFailureState extends ExploreState {
  final String message;
  ExploreFailureState(this.message);

  @override
  List<String?> get props => [message];
}

class ExploreMangaListLoadedState extends ExploreState {}

class ExploreChangeFilterState<T> extends ExploreState {
  final T value;
  final MangaParamType? type;

  ExploreChangeFilterState(this.value, [this.type]);

  @override
  List get props => [value, type];
}
