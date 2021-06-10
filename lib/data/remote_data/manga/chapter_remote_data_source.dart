import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../data_sources/manga/chapter_data_source.dart';
import '../../../models/responses/common/base_data_response.dart';

class ChapterRemoteDataSource implements ChapterDataSource {
  final Dio dio;

  ChapterRemoteDataSource({required this.dio});

  @override
  Future<BaseDataResponse<void>> markChapterRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response = await dio.post(HttpUrls.chapterRead(id));

      return BaseDataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }

  @override
  Future<BaseDataResponse<void>> markChapterUnRead(String id) {
    return ExceptionHandler.api(() async {
      final Response response = await dio.delete(HttpUrls.chapterRead(id));

      return BaseDataResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) {},
      );
    });
  }
}
