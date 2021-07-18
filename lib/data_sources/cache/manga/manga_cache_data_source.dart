import 'dart:async';

import '../../../models/master/manga_master_model.dart';
import '../../../services/db_service.dart';

class MangaCacheDataSource {
  final DBService _dbClient;

  MangaCacheDataSource({
    required DBService dbClient,
  }) : _dbClient = dbClient;

// Converted to `FutureOr` because in future might change DB;
  FutureOr<void> storeManga(List<MangaMasterModel> mangaList) {
    for (final manga in mangaList) {
      _dbClient.set("manga://${manga.id}", manga.toJson());
    }
  }

  FutureOr<MangaMasterModel?> getManga(String id) {
    final response = _dbClient.get<Map<String, dynamic>>("manga://$id");
    if (response == null) return null;

    return MangaMasterModel.fromJson(response);
  }

  FutureOr<void> storeMangaCoverArt(List<MangaMasterModel> mangaList) {
    for (final manga in mangaList) {
      if (manga.coverUrl != null && manga.coverUrl!.isNotEmpty) {
        _dbClient.set<String>("cover_art://${manga.id}", manga.coverUrl!);
      }
    }
  }

  FutureOr<String?> getMangaCoverArt(MangaMasterModel manga) {
    final response = _dbClient.get<String>("cover_art://${manga.id}");

    return response;
  }
}
