import 'package:json_annotation/json_annotation.dart';

part 'chapter_master_model.g.dart';

@JsonSerializable()
class ChapterMasterModel {
  String? id;
  String? mangaId;

  String title;
  String volume;
  String chapter;

  List<String> data;
  List<String> dataSaver;

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
    this.data = const [],
    this.dataSaver = const [],
    this.hash,
    this.translatedLanguage,
    this.createdAt,
    this.updatedAt,
    this.publishAt,
  });

  factory ChapterMasterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterMasterModelToJson(this);

  @override
  String toString() {
    return 'ChapterMasterModel(id: $id, mangaId: $mangaId, title: $title, volume: $volume, chapter: $chapter, data: $data, dataSaver: $dataSaver, hash: $hash, translatedLanguage: $translatedLanguage, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
  }
}
