// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ChapterListParamsToJson(ChapterListParams instance) {
  final val = <String, dynamic>{
    'mangaId': instance.mangaId,
    'limit': instance.limit,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  val['translatedLanguage'] = instance.translatedLanguage;
  writeNotNull('order', instance.order?.toJson());
  return val;
}

Map<String, dynamic> _$ChapterOrderToJson(ChapterOrder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('volume', _$OrderByEnumMap[instance.volume]);
  writeNotNull('chapter', _$OrderByEnumMap[instance.chapter]);
  return val;
}

const _$OrderByEnumMap = {
  OrderBy.asc: 'asc',
  OrderBy.desc: 'desc',
};
