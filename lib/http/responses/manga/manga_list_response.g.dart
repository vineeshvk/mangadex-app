// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaListResponse _$MangaListResponseFromJson(Map<String, dynamic> json) {
  return MangaListResponse(
    results: ModelHelper.fromJsonBaseDataWithBaseItemWithManga(
        json['results'] as List<dynamic>),
  )
    ..limit = json['limit'] as int?
    ..offset = json['offset'] as int?
    ..total = json['total'] as int?;
}
