import 'package:flutter/material.dart';

import 'core/utils/dio_util.dart';
import 'data_sources/remote_data/manga/chapter_remote_data_source.dart';
import 'features/reading/reading_screen.dart';
import 'models/master/manga_master_model.dart';
import 'models/params/manga/chapter_list_params.dart';
import 'repositories/manga/chapter_repository.dart';

Future<void> main() async {
  final repo = ChapterRepository(
    chapterDataSource: ChapterRemoteDataSource(networkClient: DioUtil().dio),
  );

  final list = await repo.getChapterList(
      ChapterListParams(mangaId: "cf05fa96-b52a-4684-b884-00f0d4c21f9c"));

  final manga = MangaMasterModel(
      title: "juliet", tags: ["romance"], originalLanguage: "jp");
  manga.chapters = list.data!;

  runApp(MaterialApp(home: ReadingScreen(chapterIndex: 3, manga: manga)));
}
