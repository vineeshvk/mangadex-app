import 'package:bloc/bloc.dart';

import '../../../core/utils/base_equatable.dart';
import '../../../models/master/chapter_master_model.dart';
import '../../../models/master/manga_master_model.dart';
import '../../../models/params/manga/chapter_list_params.dart';
import '../../../models/responses/base_response.dart';
import '../../../repositories/manga/chapter_repository.dart';

part 'chapter_list_state.dart';

class ChapterListCubit extends Cubit<ChapterListState> {
  //constant values
  final ChapterRepository _chapterRepository;

  //state values
  final MangaMasterModel manga;
  final ChapterListParams _chapterParams;
  ChapterOrder get order => _chapterParams.order;

  ChapterListCubit({
    required ChapterRepository chapterRepository,
    required this.manga,
  })  : _chapterRepository = chapterRepository,
        _chapterParams = ChapterListParams(mangaId: manga.id!),
        super(ChapterListIdleState());

  Future<void> init() async {
    emit(ChapterListLoadingState());

    final BaseResponse<List<ChapterMasterModel>> chapterResponse =
        await _chapterRepository.getChapterList(_chapterParams);

    if (chapterResponse.hasError) {
      emit(ChapterListErrorState(chapterResponse.errorMessage));
      return;
    }

    manga.chapters = chapterResponse.data!;

    emit(ChapterListLoadedState());
  }
}
