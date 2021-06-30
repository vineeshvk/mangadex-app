// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaMasterModel _$MangaMasterModelFromJson(Map<String, dynamic> json) {
  return MangaMasterModel(
    title: json['title'] as String,
    tags: (json['tags'] as List<dynamic>).map((e) => e as String?).toList(),
    originalLanguage: json['originalLanguage'] as String,
    id: json['id'] as String?,
    year: json['year'] as int?,
    status: json['status'] as String?,
    updatedAt: json['updatedAt'] as String?,
    createdAt: json['createdAt'] as String?,
    description: json['description'] as String?,
    contentRating: json['contentRating'] as String?,
    publicationDemographic: json['publicationDemographic'] as String?,
  )
    ..coverId = json['coverId'] as String?
    ..isInLibrary = json['isInLibrary'] as bool?
    ..lastReadChapterId = json['lastReadChapterId'] as String?
    ..coverUrl = json['coverUrl'] as String?;
}

Map<String, dynamic> _$MangaMasterModelToJson(MangaMasterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'originalLanguage': instance.originalLanguage,
      'publicationDemographic': instance.publicationDemographic,
      'status': instance.status,
      'year': instance.year,
      'contentRating': instance.contentRating,
      'tags': instance.tags,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'coverId': instance.coverId,
      'isInLibrary': instance.isInLibrary,
      'lastReadChapterId': instance.lastReadChapterId,
      'coverUrl': instance.coverUrl,
    };
