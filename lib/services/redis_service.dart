import 'package:redis_dart/redis_dart.dart';

abstract class RedisService {
  static late final RedisClient _client;

  Future<void> init() async {
    _client = await RedisClient.connect("localhost");
  }

  Future<Map<String, dynamic>?> get(String key) async {
    final response = await _client.getMap(key);
    if (response.value == null) return null;

    return response.value as Map<String, dynamic>;
  }

  Future<void> set(String key, Map<String, dynamic> value,
      [Duration? expiresIn]) async {
    await _client.setMap(key, value);

    if (expiresIn != null) {
      _client.expire(key, expiresIn);
    }
  }
}
