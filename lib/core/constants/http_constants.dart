class HttpConstants {
  static const baseUrl = 'https://api.mangadex.org';

  static String createCoverUrl(String mangaId, String coverFileName) =>
      "https://uploads.mangadex.org/covers/$mangaId/$coverFileName";
}
