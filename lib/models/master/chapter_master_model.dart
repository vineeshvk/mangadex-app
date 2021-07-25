import 'package:json_annotation/json_annotation.dart';

import '../../core/constants/http_constants.dart';
import '../manga/chapter_item_model.dart';

part 'chapter_master_model.g.dart';

@JsonSerializable()
class ChapterMasterModel {
  String? id;
  String? mangaId;

  String title;
  String volume;
  String? chapter;

  /// Contains the list of page urls for a particular chapter
  List<String> pages;

  /// Contains the list of page urls for a particular chapter with lower quality
  List<String> pagesLowQ;

  String? hash;
  String? translatedLanguage;

  String? createdAt;
  String? updatedAt;
  String? publishAt;

  ChapterMasterModel({
    this.id,
    this.mangaId,
    required this.title,
    required this.volume,
    required this.chapter,
    this.pages = const [],
    this.pagesLowQ = const [],
    this.hash,
    this.translatedLanguage,
    this.createdAt,
    this.updatedAt,
    this.publishAt,
  });

  factory ChapterMasterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterMasterModelToJson(this);

  factory ChapterMasterModel.fromChapterModel(ChapterItemModel chapterModel) {
    final pages = chapterModel.data
        .map((page) => _constructPageUrl(page, chapterModel.hash))
        .toList();
    final pagesLowQ = chapterModel.dataSaver
        .map((page) => _constructPageUrl(page, chapterModel.hash, true))
        .toList();

    return ChapterMasterModel(
      id: chapterModel.id,
      mangaId: chapterModel.id,
      title: chapterModel.title,
      volume: chapterModel.volume,
      chapter: chapterModel.chapter,
      pages: pages,
      pagesLowQ: pagesLowQ,
      hash: chapterModel.hash,
      translatedLanguage: chapterModel.translatedLanguage,
      createdAt: chapterModel.createdAt,
      updatedAt: chapterModel.updatedAt,
      publishAt: chapterModel.publishAt,
    );
  }

  static String _constructPageUrl(String filePath, String hash,
      [bool isDataSaver = false]) {
    final quality = isDataSaver ? "data-saver" : "data";
    return "${HttpConstants.uploadBaseUrl}/$quality/$hash/$filePath";
  }

  @override
  String toString() {
    return 'ChapterMasterModel(id: $id, mangaId: $mangaId, title: $title, volume: $volume, chapter: $chapter, pages: $pages, pagesLowQ: $pagesLowQ, hash: $hash, translatedLanguage: $translatedLanguage, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
  }
}
