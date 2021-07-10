import '../../../models/master/manga_master_model.dart';
import '../../../services/redis_service.dart';

class MangaCacheDataSource {
  final RedisService _dbClient;

  MangaCacheDataSource({
    required RedisService dbClient,
  }) : _dbClient = dbClient;

  Future<void> storeMangaList(List<MangaMasterModel> mangaList) async {
    for (final manga in mangaList) {
      await _dbClient.set("manga://${manga.id}", manga.toJson());
    }
  }

  Future<MangaMasterModel?> getManga(String id) async {
    final Map<String, dynamic>? response = await _dbClient.get("manga://$id");
    if (response == null) return null;

    return MangaMasterModel.fromJson(response);
  }

  Future<void> storeMangaCoverArt(List<MangaMasterModel> mangaList) async {
    for (final manga in mangaList) {
      if (manga.coverUrl != null && manga.coverUrl!.isNotEmpty) {
        await _dbClient.setString("cover_art://${manga.id}", manga.coverUrl!);
      }
    }
  }

  Future<String?> getMangaCoverArt(MangaMasterModel manga) async {
    final response = await _dbClient.getString("cover_art://${manga.id}");

    return response;
  }
}
