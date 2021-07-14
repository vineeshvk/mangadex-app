import '../../../models/master/manga_master_model.dart';
import '../../../services/db_service.dart';

class MangaCacheDataSource {
  final DBService _dbClient;

  MangaCacheDataSource({
    required DBService dbClient,
  }) : _dbClient = dbClient;

  void storeMangaList(List<MangaMasterModel> mangaList) {
    for (final manga in mangaList) {
      _dbClient.set("manga://${manga.id}", manga.toJson());
    }
  }

  MangaMasterModel? getManga(String id) {
    final Map<String, dynamic>? response = _dbClient.get("manga://$id");
    if (response == null) return null;

    return MangaMasterModel.fromJson(response);
  }

  void storeMangaCoverArt(List<MangaMasterModel> mangaList) {
    for (final manga in mangaList) {
      if (manga.coverUrl != null && manga.coverUrl!.isNotEmpty) {
        _dbClient.set<String>("cover_art://${manga.id}", manga.coverUrl!);
      }
    }
  }

  String? getMangaCoverArt(MangaMasterModel manga) {
    final response = _dbClient.get<String>("cover_art://${manga.id}");

    return response;
  }
}
