import 'package:flutter_test/flutter_test.dart';
import 'package:mangadex/data_sources/cache/manga/manga_cache_data_source.dart';
import 'package:mangadex/models/master/manga_master_model.dart';
import 'package:mangadex/services/db_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDBService extends Mock implements DBService {}

void main() {
  final DBService dbClient = MockDBService();
  final cacheDataSource = MangaCacheDataSource(dbClient: dbClient);
  when(() => dbClient.set<Map>(any(), any())).thenAnswer((_) async {});

  final mangaRes = {
    "title": "title",
    "tags": ["action"],
    "originalLanguage": "originalLanguage",
    "coverUrl": "cover_art"
  };

  final mangaMasterRes = MangaMasterModel.fromJson(mangaRes);

  group("Manga cache", () {
    test("get manga", () {
      when(() => dbClient.get<Map>(any())).thenReturn(mangaRes);
      expect(
        cacheDataSource.getManga("1"),
        isA<MangaMasterModel>().having(
          (model) => model.tags,
          "tags",
          isNotEmpty,
        ),
      );

      when(() => dbClient.get<Map>(any())).thenReturn(null);
      expect(cacheDataSource.getManga("1"), isNull);
    });

    test("store manga", () {
      cacheDataSource.storeManga([mangaMasterRes]);
    });

    test("store manga cover", () {
      cacheDataSource.storeManga([mangaMasterRes]);
    });

    test("get manga cover", () {
      when(() => dbClient.get<String>(any())).thenReturn("http://");

      expect(cacheDataSource.getMangaCoverArt(mangaMasterRes), "http://");
    });
  });
}
