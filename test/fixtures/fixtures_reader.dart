import 'dart:convert';
import 'dart:io';

class Fixtures {
  static const error = "common/error.json";

  static const mangaList = "manga/manga_list.json";
  static const tagList = "manga/tag_list.json";

  static const status = "common/status.json";

  static const token = "auth/token_fixtures.json";

  static Map<String, dynamic> parse(String name) {
    final file = File('test/fixtures/$name').readAsStringSync();
    return json.decode(json.encode(json.decode(file))) as Map<String, dynamic>;
  }

  static List parseList(String name) {
    final file = File('test/fixtures/$name').readAsStringSync();
    return json.decode(json.encode(json.decode(file))) as List;
  }
}
