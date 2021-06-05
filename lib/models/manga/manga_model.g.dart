// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) {
  return MangaModel(
    title: LabelModel.fromJson(json['title'] as Map<String, dynamic>),
    altTitles: (json['altTitles'] as List<dynamic>)
        .map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    description:
        LabelModel.fromJson(json['description'] as Map<String, dynamic>),
    originalLanguage: json['originalLanguage'] as String,
    publicationDemographic: json['publicationDemographic'] as String?,
    status: json['status'] as String?,
    year: json['year'] as int?,
    contentRating: json['contentRating'] as String?,
    tags: ModelHelper.fromJsonBaseItemWithTag(json['tags'] as List),
    version: json['version'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}
