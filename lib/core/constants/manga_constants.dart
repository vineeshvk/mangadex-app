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
  coverArt,
  author,
  artist,
  scanlationGroup,
  tag,
  user,
  customList,
}

enum IncludedModes { and, or }

enum OrderBy { asc, desc }
