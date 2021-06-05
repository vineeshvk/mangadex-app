import '../../../core/exception/api_exception.dart';
import '../../data_sources/manga/manga_data_source.dart';
import '../../models/params/manga/manga_list_params.dart';
import '../../models/responses/base_response.dart';
import '../../models/responses/manga/manga_list_response.dart';

class MangaRespository {
  MangaDataSource mangaDataSource;

  MangaRespository({
    required this.mangaDataSource,
  });

  Future<BaseResponse<MangaListResponse>> getMangaList([
    MangaListParams? params,
  ]) async {
    BaseResponse<MangaListResponse> response;

    try {
      final MangaListResponse mangaList = await mangaDataSource.getMangaList(
        params,
      );
      response = BaseResponse(response: mangaList);
    } on ApiException catch (exception) {
      response = BaseResponse(error: exception.error);
    }

    return response;
  }
}
