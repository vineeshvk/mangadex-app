import 'package:json_annotation/json_annotation.dart';

enum MangaPublicationDemography {
  josei,
  seinen,
  shoujo,
  shounen,
}

enum MangaStatus {
  ongoing,
  completed,
  hiatus,
  cancelled,
}

enum MangaReadingStatus {
  reading,
  onHold,
  planToRead,
  dropped,
  reReading,
  completed,
}

enum MangaContentRating {
  safe,
  suggestive,
  erotica,
  pornographic,
}

enum CustomListVisibility {
  public,
  private,
}

enum MangaRelationshipTypes {
  manga,
  chapter,
  @JsonValue("cover_art")
  coverArt,
  author,
  artist,
  @JsonValue("scanlation_group")
  scanlationGroup,
  tag,
  user,
  @JsonValue("custom_list")
  customList,
}

enum IncludedModes { and, or }

enum OrderBy { asc, desc }
