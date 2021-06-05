import 'package:json_annotation/json_annotation.dart';

import '../../../data/constants/common_constants.dart';
import '../../../data/constants/manga_constants.dart';

part 'manga_list_params.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class MangaListParams {
  /// limit for querying default value is [10]
  int? limit;

  /// query from offset; offset > 0
  int? offset;

  /// title of the manga
  String? title;

  /// list of authors relationship ids
  List<String>? authors;

  /// year of release
  int? year;

  /// list of tag uuid to be included
  List<String>? includedTags;

  /// included tag mode.
  /// value either [and, or]. 
  /// default value [and]
  @JsonKey(toJson: _includedModesEnumToString)
  IncludedModes? includedTagsMode;

  /// list of tag uuid to be excluded
  List<String>? excludedTags;

  /// status of the manga MangaStatus [ongoing, completed, hiatus, cancelled]
  MangaStatus? status;

  /// original language of the manga
  String? originalLanguage;

  /// publication demographic for the manga [shonen, shoujo, josei, seinen, none]
  MangaPublicationDemography? publicationDemographic;

  /// list of manga ids to search
  List<String>? ids;

  /// list content ratings to be included [safe, suggestive, erotica, pornographic]
  List<MangaContentRating>? contentRating;

  /// manga created date
  DateTime? createdAtSince;

  /// manga updated date
  DateTime? updatedAtSince;

  /// order the manga list by [asc, desc] with createdAtSince date
  OrderBy? createdAt;

  /// order the manga list by [asc, desc] with updatedAtSince date
  OrderBy? updatedAt;

  MangaListParams({
    this.limit,
    this.offset,
    this.title,
    this.authors,
    this.year,
    this.includedTags,
    this.includedTagsMode,
    this.excludedTags,
    this.status,
    this.originalLanguage,
    this.publicationDemographic,
    this.ids,
    this.contentRating,
    this.createdAtSince,
    this.updatedAtSince,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$MangaListParamsToJson(this);
}

String? _includedModesEnumToString(IncludedModes? includedModes) {
  const includedModesEnumMap = {
    IncludedModes.and: 'AND',
    IncludedModes.or: 'OR',
  };

  if (includedModes == null) return null;

  return includedModesEnumMap[includedModes];
}
