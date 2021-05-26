import 'package:dio/dio.dart';

import '../../../core/exception/api_exception.dart';
import '../../../http/http_urls.dart';
import '../../../http/responses/common/error_response.dart';
import '../../../http/responses/manga/manga_list_response.dart';

class MangaDataSource {
  final Dio dio;

  MangaDataSource({required this.dio});

  Future<MangaListResponse> getMangaList() async {
    try {
      final Response response = await dio.get(
        HttpUrls.manga,
      );

      return MangaListResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (dioError) {
      final Map<String, dynamic>? error =
          dioError.response?.data as Map<String, dynamic>?;

      throw ApiException(
        error: error != null ? ErrorResponse.fromJson(error) : null,
      );
    } catch (e) {
      throw ApiException();
    }
  }
}
