// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterMasterModel _$ChapterMasterModelFromJson(Map<String, dynamic> json) {
  return ChapterMasterModel(
    id: json['id'] as String?,
    mangaId: json['mangaId'] as String?,
    title: json['title'] as String,
    volume: json['volume'] as String,
    chapter: json['chapter'] as String,
    data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    dataSaver:
        (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    hash: json['hash'] as String?,
    translatedLanguage: json['translatedLanguage'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    publishAt: json['publishAt'] as String?,
  );
}

Map<String, dynamic> _$ChapterMasterModelToJson(ChapterMasterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mangaId': instance.mangaId,
      'title': instance.title,
      'volume': instance.volume,
      'chapter': instance.chapter,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
      'hash': instance.hash,
      'translatedLanguage': instance.translatedLanguage,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishAt': instance.publishAt,
    };
