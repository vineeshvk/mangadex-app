import 'dart:convert';
import 'dart:io';

class Fixtures {
  static const error = "common/error.json";

  static const mangaList = "manga/manga_list.json";

  static Map<String, dynamic> parse(String name) {
    final file = File('test/fixtures/$name').readAsStringSync();
    return json.decode(json.encode(json.decode(file))) as Map<String, dynamic>;
  }
}
