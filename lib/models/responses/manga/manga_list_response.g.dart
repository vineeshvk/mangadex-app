// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaListResponse _$MangaListResponseFromJson(Map<String, dynamic> json) {
  return MangaListResponse(
    results: ModelHelper.fromJsonBaseDataWithBaseItemWithManga(
        json['results'] as List),
  )
    ..limit = json['limit'] as int? ?? 0
    ..offset = json['offset'] as int? ?? 0
    ..total = json['total'] as int? ?? 0;
}
