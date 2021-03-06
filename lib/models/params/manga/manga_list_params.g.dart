// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MangaListParamsToJson(MangaListParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('authors', instance.authors);
  writeNotNull('year', instance.year);
  writeNotNull('includedTags', instance.includedTags);
  writeNotNull(
      'includedTagsMode', _$IncludedModesEnumMap[instance.includedTagsMode]);
  writeNotNull('excludedTags', instance.excludedTags);
  val['excludedTagsMode'] = _$IncludedModesEnumMap[instance.excludedTagsMode];
  writeNotNull(
      'status', instance.status?.map((e) => _$MangaStatusEnumMap[e]).toList());
  writeNotNull('originalLanguage', instance.originalLanguage);
  writeNotNull(
      'publicationDemographic',
      instance.publicationDemographic
          ?.map((e) => _$MangaPublicationDemographyEnumMap[e])
          .toList());
  writeNotNull('ids', instance.ids);
  writeNotNull(
      'contentRating',
      instance.contentRating
          ?.map((e) => _$MangaContentRatingEnumMap[e])
          .toList());
  writeNotNull('createdAtSince', instance.createdAtSince?.toIso8601String());
  writeNotNull('updatedAtSince', instance.updatedAtSince?.toIso8601String());
  writeNotNull('createdAt', _$OrderByEnumMap[instance.createdAt]);
  writeNotNull('updatedAt', _$OrderByEnumMap[instance.updatedAt]);
  val['limit'] = instance.limit;
  writeNotNull('offset', instance.offset);
  return val;
}

const _$IncludedModesEnumMap = {
  IncludedModes.and: 'AND',
  IncludedModes.or: 'OR',
};

const _$MangaStatusEnumMap = {
  MangaStatus.ongoing: 'ongoing',
  MangaStatus.completed: 'completed',
  MangaStatus.hiatus: 'hiatus',
  MangaStatus.cancelled: 'cancelled',
};

const _$MangaPublicationDemographyEnumMap = {
  MangaPublicationDemography.josei: 'josei',
  MangaPublicationDemography.seinen: 'seinen',
  MangaPublicationDemography.shoujo: 'shoujo',
  MangaPublicationDemography.shounen: 'shounen',
};

const _$MangaContentRatingEnumMap = {
  MangaContentRating.safe: 'safe',
  MangaContentRating.suggestive: 'suggestive',
  MangaContentRating.erotica: 'erotica',
  MangaContentRating.pornographic: 'pornographic',
};

const _$OrderByEnumMap = {
  OrderBy.asc: 'asc',
  OrderBy.desc: 'desc',
};
