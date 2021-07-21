// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterItemModel _$ChapterItemModelFromJson(Map<String, dynamic> json) {
  return ChapterItemModel(
    title: json['title'] as String,
    volume: json['volume'] as String,
    chapter: json['chapter'] as String,
    data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    dataSaver:
        (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    hash: json['hash'] as String?,
    translatedLanguage: json['translatedLanguage'] as String?,
  )
    ..id = json['id'] as String?
    ..createdAt = json['createdAt'] as String?
    ..updatedAt = json['updatedAt'] as String?
    ..publishAt = json['publishAt'] as String?;
}
