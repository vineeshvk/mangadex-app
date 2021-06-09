import '../../../models/responses/manga/manga_list_response.dart';
import '../../models/params/manga/manga_list_params.dart';
import '../../models/responses/manga/tag_list_response.dart';

abstract class MangaDataSource {
  Future<MangaListResponse> getMangaList([MangaListParams? params]);

  Future<TagListResponse> getTagList();
}
