import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex/models/responses/common/pagination_handler.dart';

import '../../../core/constants/manga_constants.dart';
import '../../../core/utils/extensions_util.dart';

part 'manga_list_params.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class MangaListParams {
  /// title of the manga
  String? title;

  /// list of authors relationship ids
  List<String>? authors;

  /// year of release
  int? year;

  /// list of tag uuid to be included
  List<String>? includedTags;

  /// included tag mode.
  /// value either `[and, or]`.
  /// default value `[and]`
  IncludedModes? includedTagsMode;

  /// list of tag uuid to be excluded
  List<String>? excludedTags;

  /// excluded tag mode.
  /// value either `[and, or]`.
  /// default value `[and]`
  // @JsonKey(toJson: _includedModesEnumToString)
  IncludedModes excludedTagsMode;

  /// status of the manga to be included; MangaStatus [ongoing, completed, hiatus, cancelled]
  List<MangaStatus>? status;

  /// original language of the manga to be included
  List<String>? originalLanguage;

  /// publication demographic to be included for the manga `[shonen, shoujo, josei, seinen, none]`
  List<MangaPublicationDemography>? publicationDemographic;

  /// list of manga ids to search
  List<String>? ids;

  /// list content ratings to be included `[safe, suggestive, erotica, pornographic]`
  List<MangaContentRating>? contentRating;

  /// manga created date
  DateTime? createdAtSince;

  /// manga updated date
  DateTime? updatedAtSince;

  /// order the manga list by `[asc, desc]` with createdAtSince date
  OrderBy? createdAt;

  /// order the manga list by `[asc, desc]` with updatedAtSince date
  OrderBy? updatedAt;

  @JsonKey(ignore: true)
  PaginationHandler? pagination;

  /// limit for querying default value is `[15]`
  int get limit => pagination?.limit ?? 15;

  /// query from offset; offset > 0
  int? get offset => pagination?.nextPage();

  MangaListParams({
    this.title,
    this.authors,
    this.year,
    this.includedTags,
    this.includedTagsMode = IncludedModes.and,
    this.excludedTags,
    this.excludedTagsMode = IncludedModes.or,
    this.status,
    this.originalLanguage,
    this.publicationDemographic,
    this.ids,
    this.contentRating,
    this.createdAtSince,
    this.updatedAtSince,
    this.createdAt,
    this.updatedAt,
    this.pagination,
  });

  Map<String, dynamic> toJson() => _$MangaListParamsToJson(this);

  void setFilter<T>(MangaParamType type, T value) {
    switch (type) {
      case MangaParamType.includedTags:
        includedTags = includedTags.checkBox(value as String);
        break;

      case MangaParamType.includedTagsMode:
        includedTagsMode = value as IncludedModes;
        break;

      case MangaParamType.excludedTags:
        excludedTags = excludedTags.checkBox(value as String);
        break;

      case MangaParamType.status:
        status = status.checkBox(value as MangaStatus);
        break;

      case MangaParamType.originalLanguage:
        originalLanguage = originalLanguage.checkBox(value as String);
        break;

      case MangaParamType.publicationDemographic:
        publicationDemographic = publicationDemographic
            .checkBox(value as MangaPublicationDemography);
        break;

      case MangaParamType.contentRating:
        contentRating = contentRating.checkBox(value as MangaContentRating);
        break;

      case MangaParamType.createdAt:
        if (createdAt == null) {
          createdAt = OrderBy.desc;
        } else if (createdAt == OrderBy.asc) {
          createdAt = OrderBy.desc;
        } else {
          createdAt = OrderBy.asc;
        }
        updatedAt = null;
        break;

      case MangaParamType.updatedAt:
        if (updatedAt == null) {
          updatedAt = OrderBy.desc;
        } else if (updatedAt == OrderBy.asc) {
          updatedAt = OrderBy.desc;
        } else {
          updatedAt = OrderBy.asc;
        }
        createdAt = null;
        break;
      case MangaParamType.defaultSort:
        updatedAt = null;
        createdAt = null;
        break;
    }
  }

  @override
  String toString() => toJson().toString();
}

enum MangaParamType {
  includedTags,
  includedTagsMode,
  excludedTags,
  status,
  originalLanguage,
  publicationDemographic,
  contentRating,
  createdAt,
  updatedAt,
  defaultSort,
}
