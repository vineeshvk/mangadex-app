// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseItemModel<T> _$BaseItemModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseItemModel<T>(
    id: json['id'] as String,
    type: _$enumDecode(_$MangaRelationshipTypesEnumMap, json['type']),
    attributes: fromJsonT(json['attributes']),
  );
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MangaRelationshipTypesEnumMap = {
  MangaRelationshipTypes.manga: 'manga',
  MangaRelationshipTypes.chapter: 'chapter',
  MangaRelationshipTypes.coverArt: 'cover_art',
  MangaRelationshipTypes.author: 'author',
  MangaRelationshipTypes.artist: 'artist',
  MangaRelationshipTypes.scanlationGroup: 'scanlation_group',
  MangaRelationshipTypes.tag: 'tag',
  MangaRelationshipTypes.user: 'user',
  MangaRelationshipTypes.customList: 'custom_list',
};
