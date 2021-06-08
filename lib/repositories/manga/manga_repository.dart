import '../../core/exception/exception_handler.dart';
import '../../data_sources/manga/manga_data_source.dart';
import '../../models/params/manga/manga_list_params.dart';
import '../../models/responses/base_response.dart';
import '../../models/responses/manga/manga_list_response.dart';

class MangaRepository {
  MangaDataSource mangaDataSource;

  MangaRepository({
    required this.mangaDataSource,
  });

  Future<BaseResponse<MangaListResponse>> getMangaList([
    MangaListParams? params,
  ]) async {
    return ExceptionHandler.repo(() async {
      final MangaListResponse mangaList = await mangaDataSource.getMangaList(
        params,
      );

      return mangaList;
    });
  }
}
