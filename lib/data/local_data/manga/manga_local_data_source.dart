import '../../../data_sources/manga/manga_data_source.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/manga/manga_list_response.dart';

class MangaLocalDataSource implements MangaDataSource {
  @override
  Future<MangaListResponse> getMangaList([MangaListParams? params]) {
    // TODO: implement getMangaList
    throw UnimplementedError();
  }
}
