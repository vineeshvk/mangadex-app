// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaItemModel _$MangaItemModelFromJson(Map<String, dynamic> json) {
  return MangaItemModel(
    title: LabelModel.fromJson(json['title'] as Map<String, dynamic>),
    description:
        LabelModel.fromJson(json['description'] as Map<String, dynamic>),
    originalLanguage: json['originalLanguage'] as String,
    altTitles: (json['altTitles'] as List<dynamic>?)
        ?.map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    publicationDemographic: json['publicationDemographic'] as String?,
    status: json['status'] as String?,
    year: json['year'] as int?,
    contentRating: json['contentRating'] as String?,
    tags: ModelHelper.fromJsonBaseItemWithTag(json['tags'] as List),
    version: json['version'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  )..id = json['id'] as String?;
}
