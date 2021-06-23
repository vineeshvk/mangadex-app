import '../../core/exception/exception_handler.dart';
import '../../data_sources/remote_data/manga/manga_remote_data_source.dart';
import '../../models/master/manga_master_model.dart';
import '../../models/params/manga/manga_list_params.dart';
import '../../models/responses/base_response.dart';
import '../../models/responses/manga/tag_list_response.dart';

class MangaRepository {
  MangaRemoteDataSource mangaDataSource;

  MangaRepository({
    required this.mangaDataSource,
  });

  Future<BaseResponse<List<MangaMasterModel>>> getMangaList([
    MangaListParams? params,
  ]) async {
    return ExceptionHandler.repo(() async {
      final List<MangaMasterModel> mangaList =
          await mangaDataSource.getMangaList(
        params,
      );

      return mangaList;
    });
  }

  Future<BaseResponse<TagListResponse>> getTagList() async {
    return ExceptionHandler.repo(() async {
      final TagListResponse tagList = await mangaDataSource.getTagList();

      return tagList;
    });
  }
}
