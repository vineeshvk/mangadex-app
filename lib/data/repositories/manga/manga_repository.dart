import '../../../core/exception/api_exception.dart';
import '../../../http/responses/base_response.dart';
import '../../../http/responses/manga/manga_list_response.dart';
import '../../data_sourcers/manga/manga_data_source.dart';

class MangaRespository {
  MangaDataSource mangaDataSource;

  MangaRespository({
    required this.mangaDataSource,
  });

  Future<BaseResponse<MangaListResponse>> getMangaList() async {
    BaseResponse<MangaListResponse> response;

    try {
      final MangaListResponse mangaList = await mangaDataSource.getMangaList();
      response = BaseResponse(response: mangaList);
    } on ApiException catch (exception) {
      response = BaseResponse(error: exception.error);
    }

    return response;
  }
}
