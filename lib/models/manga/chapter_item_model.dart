import 'package:json_annotation/json_annotation.dart';

part 'chapter_item_model.g.dart';

@JsonSerializable(createToJson: false)
class ChapterItemModel {
  String? id;

  String title;
  String volume;
  String? chapter;

  String? translatedLanguage;
  String hash;

  List<String> data;
  List<String> dataSaver;

  String? createdAt;
  String? updatedAt;
  String? publishAt;

  ChapterItemModel({
    required this.title,
    required this.volume,
    required this.chapter,
    required this.hash,
    this.data = const [],
    this.dataSaver = const [],
    this.translatedLanguage,
  });

  factory ChapterItemModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterItemModelFromJson(json);

  @override
  String toString() {
    return 'ChapterItemModel(id: $id, title: $title, volume: $volume, chapter: $chapter, translatedLanguage: $translatedLanguage, hash: $hash, data: $data, dataSaver: $dataSaver, createdAt: $createdAt, updatedAt: $updatedAt, publishAt: $publishAt)';
  }
}
