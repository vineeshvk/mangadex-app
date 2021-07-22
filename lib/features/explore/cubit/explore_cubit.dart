import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/manga_master_model.dart';
import '../../../models/master/tag_master_model.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/base_response.dart';
import '../../../models/responses/common/pagination_handler.dart';
import '../../../repositories/manga/manga_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  //constant values
  late TextEditingController searchTextController;

  final MangaRepository _mangaRepository;
  PaginationHandler? _mangaListPagination;

  //state values
  List<MangaMasterModel> mangaList = [];
  late MangaListParams mangaListParams;

  /// [tagList] is the complete list of tags; The selected tags will be handled in [mangaListParams]
  List<TagMasterModel> tagList = [];

  ExploreCubit({required MangaRepository mangaRepository})
      : _mangaRepository = mangaRepository,
        super(ExploreIdleState());

  //events
  Future<void> init() async {
    emit(ExploreLoadingState());
    mangaListParams = MangaListParams();
    searchTextController = TextEditingController();

    // Make sure always the tag list data should be fetched first; As there is no state emitted
    _getTagsList();
    _getMangaList();
  }

  Future<void> searchManga() async {
    if (mangaListParams.title == searchTextController.text.trim()) return;

    mangaListParams.title = searchTextController.text.trim();
    await applyFilter();
  }

  void changeFilterValue<T>(MangaParamType type, T value) {
    mangaListParams.setFilter<T>(type, value);
    emit(ExploreChangeFilterState<T>(value, type));
  }

  Future<void> clearFilter() async {
    mangaListParams = MangaListParams();
    await applyFilter();
  }

  Future<void> applyFilter() async {
    mangaListParams.pagination = _mangaListPagination = null;
    emit(ExploreLoadingState());
    await _getMangaList();
  }

  Future<void> fetchMoreManga() async {
    if (_mangaListPagination?.isLastPage ?? false) return;

    mangaListParams.pagination = _mangaListPagination;
    await _getMangaList(clearPrev: false);
  }

  //services

  /// Gets the manga list from repo and set it to the `mangaList` variable.
  /// Argument `clearPrev` on `true` will clear the previous list from the `mangaList`,
  /// so when using pagination set the `clearPrev` to `false`
  Future<void> _getMangaList({bool clearPrev = true}) async {
    final BaseResponse<List<MangaMasterModel>> mangaListResponse =
        await _mangaRepository.getMangaList(mangaListParams);

    if (mangaListResponse.hasError) {
      emit(ExploreFailureState(mangaListResponse.errorMessage));
      return;
    }

    if (clearPrev) mangaList.clear();

    mangaList.addAll(mangaListResponse.data!);
    _mangaListPagination = mangaListResponse.pagination;

    emit(ExploreMangaListLoadedState());
  }

  Future<void> _getTagsList() async {
    final BaseResponse<List<TagMasterModel>> tagListResponse =
        await _mangaRepository.getTagList();

    if (tagListResponse.hasError) {
      emit(ExploreFailureState(tagListResponse.errorMessage));
      return;
    }

    tagList = tagListResponse.data!;
  }
}
