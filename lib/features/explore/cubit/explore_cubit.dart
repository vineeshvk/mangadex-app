import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/manga_master_model.dart';
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

  ExploreCubit({required MangaRepository mangaRepository})
      : _mangaRepository = mangaRepository,
        super(ExploreIdleState());

  //events
  Future<void> init() async {
    emit(ExploreLoadingState());
    mangaListParams = MangaListParams();
    searchTextController = TextEditingController();

    await _getMangaList();
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

    mangaList = mangaListResponse.response!;

    emit(ExploreMangaListLoadedState());
  }
}
