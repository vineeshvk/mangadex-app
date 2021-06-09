class HttpUrls {
  HttpUrls._();

  ///Get list of all manga and can also search
  static const String manga = "/manga";

  ///Get the total tags list
  static const String tags = "/manga/tag";

  ///Login using username&password and get the token
  static const String login = "/auth/login";
}
