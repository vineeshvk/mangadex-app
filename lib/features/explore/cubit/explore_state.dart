part of 'explore_cubit.dart';

@immutable
class ExploreState extends BaseEquatable {}

class ExploreIdleState extends ExploreState {}

class ExploreLoadingState extends ExploreState {}

class ExploreFailureState extends ExploreState {
  final String message;
  ExploreFailureState(this.message);

  @override
  List<String?> get props => [message];
}

class ExploreMangaListLoadedState extends ExploreState {}

class ExploreApplyFilterState<T> extends ExploreState {
  final T value;
  final MangaParamType? type;

  ExploreApplyFilterState(this.value, [this.type]);

  @override
  List get props => [value, type];
}
