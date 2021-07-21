import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../models/params/manga/chapter_list_params.dart';
import '../../../models/responses/common/data_response.dart';
import '../../../models/responses/manga/chapter_list_response.dart';

class ChapterRemoteDataSource {
  final Dio _networkClient;

  ChapterRemoteDataSource({required Dio networkClient})
      : _networkClient = networkClient;

  Future<DataResponse<void>> markChapterRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response =
          await _networkClient.post(HttpUrls.chapterRead(id));

      return DataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }

  Future<DataResponse<void>> markChapterUnRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response =
          await _networkClient.delete(HttpUrls.chapterRead(id));

      return DataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }

  Future<ChapterListResponse> getChapterList(ChapterListParams params) {
    return ExceptionHandler.api(() async {
      final Response response = await _networkClient.get(
        HttpUrls.chapters(params.mangaId),
        queryParameters: params.toJson(),
      );

      return ChapterListResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }
}
