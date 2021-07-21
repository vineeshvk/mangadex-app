class HttpUrls {
  HttpUrls._();

  ///Get list of all manga and can also search
  static const String manga = "/manga";

  ///Get the total tags list
  static const String tags = "/manga/tag";

  ///Get cover for a manga with coverId
  static String cover(String id) => "/cover/$id";

  ///Mark as chapter read
  static String chapterRead(String id) => "/chapter/$id/read";

  ///Login using username&password and get the token
  static const String login = "/auth/login";

  ///Get all the chapters for the provided `mangaId`
  static String chapters(String mangaId) => "manga/$mangaId/feed";
}
