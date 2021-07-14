import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../models/responses/common/base_data_response.dart';

class ChapterRemoteDataSource {
  final Dio _networkClient;

  ChapterRemoteDataSource({required Dio networkClient})
      : _networkClient = networkClient;

  Future<BaseDataResponse<void>> markChapterRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response =
          await _networkClient.post(HttpUrls.chapterRead(id));

      return BaseDataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }

  Future<BaseDataResponse<void>> markChapterUnRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response =
          await _networkClient.delete(HttpUrls.chapterRead(id));

      return BaseDataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }
}
