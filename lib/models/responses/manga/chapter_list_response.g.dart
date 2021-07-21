// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterListResponse _$ChapterListResponseFromJson(Map<String, dynamic> json) {
  return ChapterListResponse(
    results: ModelHelper.fromJsonDataWithBaseItemWithChapter(
        json['results'] as List),
  )
    ..limit = json['limit'] as int? ?? 0
    ..offset = json['offset'] as int? ?? 0
    ..total = json['total'] as int? ?? 0;
}
