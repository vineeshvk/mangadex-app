import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/manga_master_model.dart';
import '../../../models/master/tag_master_model.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/base_response.dart';
import '../../../repositories/manga/manga_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  //constant values
  late TextEditingController searchTextController;

  final MangaRepository _mangaRepository;

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

    emit(ExploreLoadingState());
    mangaListParams.title = searchTextController.text.trim();

    await _getMangaList();
  }

  void changeFilterValue<T>(MangaParamType type, T value) {
    mangaListParams.setFilter<T>(type, value);
    emit(ExploreApplyFilterState<T>(value, type));
  }

  void clearFilter() {
    mangaListParams = MangaListParams(offset: mangaListParams.offset);
    emit(ExploreApplyFilterState<bool>(true));
  }

  //services
  Future<void> _getMangaList() async {
    final BaseResponse<List<MangaMasterModel>> mangaListResponse =
        await _mangaRepository.getMangaList(mangaListParams);

    if (mangaListResponse.hasError) {
      emit(ExploreFailureState(mangaListResponse.errorMessage));
      return;
    }

    mangaList = mangaListResponse.data!;

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
