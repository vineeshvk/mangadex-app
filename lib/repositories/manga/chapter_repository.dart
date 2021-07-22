import '../../core/exception/exception_handler.dart';
import '../../data_sources/remote_data/manga/chapter_remote_data_source.dart';
import '../../models/master/chapter_master_model.dart';
import '../../models/params/manga/chapter_list_params.dart';
import '../../models/responses/base_response.dart';
import '../../models/responses/manga/chapter_list_response.dart';

class ChapterRepository {
  final ChapterRemoteDataSource _remoteDataSource;

  ChapterRepository({required ChapterRemoteDataSource chapterDataSource})
      : _remoteDataSource = chapterDataSource;

  Future<BaseResponse<List<ChapterMasterModel>>> getChapterList(
    ChapterListParams params,
  ) {
    return ExceptionHandler.repo(() async {
      final ChapterListResponse chapterResponse =
          await _remoteDataSource.getChapterList(params);

      final List<ChapterMasterModel> chapterList =
          _convertToMasterChapterList(chapterResponse, params.mangaId);

      return BaseResponse(data: chapterList, pagination: chapterResponse);
    });
  }

  List<ChapterMasterModel> _convertToMasterChapterList(
    ChapterListResponse chapterResponse,
    String mangaId,
  ) {
    final Iterable<ChapterMasterModel> chapterList =
        chapterResponse.results.map((chapter) {
      return ChapterMasterModel.fromChapterModel(chapter.data.attributes)
        ..mangaId = mangaId;
    });

    return chapterList.toList();
  }
}
