import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DBService {
  static final DBService _service = DBService._();
  late SharedPreferences _client;

  factory DBService() => _service;
  DBService._();

  /// The `init()` will initialize the database.
  /// It only needs to be initialized once. Preferably on top for the root tree.
  Future<void> init() async {
    _client = await SharedPreferences.getInstance();
  }

  /// Returns the value already stored in the database with the key
  T? get<T>(String key) {
    assert(T != dynamic);

    final response = _client.getString(key);
    if (response == null) return null;

    T? parsedResult;

    if (T == String) parsedResult = response as T;

    return parsedResult ?? (jsonDecode(response) as T);
  }

  /// Sets the given value by encoding it as String to the database with the key given.
  /// The database will be stored synchronously, so no need to await it.
  Future<void> set<T>(String key, T value) async {
    assert(T != dynamic);
    String? jsonString;

    if (value is String) jsonString = value;

    jsonString ??= jsonEncode(value);

    await _client.setString(key, jsonString);
  }

  /// Removes the value for the given key;
  Future<void> remove(String key) async {
    await _client.remove(key);
  }

  /// Clears all the db;
  Future<void> clear() async {
    await _client.clear();
  }
}
