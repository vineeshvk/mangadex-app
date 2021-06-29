import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/manga_master_model.dart';
import '../../../models/responses/base_response.dart';
import '../../../repositories/manga/manga_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  MangaRepository mangaRepository;

  List<MangaMasterModel> mangaList = [];

  ExploreCubit({
    required this.mangaRepository,
  }) : super(ExploreIdleState());

  Future<void> init() async {
    emit(ExploreLoadingState());

    final BaseResponse<List<MangaMasterModel>> mangaListResponse =
        await mangaRepository.getMangaList();

    if (mangaListResponse.hasError) {
      emit(ExploreFailureState(mangaListResponse.errorMessage));
      return;
    }

    mangaList = mangaListResponse.response ?? [];

    emit(ExploreMangaListLoadedState());
  }
}
