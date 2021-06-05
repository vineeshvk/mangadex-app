import '../../../models/responses/manga/manga_list_response.dart';
import '../../models/params/manga/manga_list_params.dart';

abstract class MangaDataSource {
  Future<MangaListResponse> getMangaList([MangaListParams? params]);
}
