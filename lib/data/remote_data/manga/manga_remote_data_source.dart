import 'package:dio/dio.dart';
import '../../../core/constants/http_urls.dart';
import '../../../core/exception/api_exception.dart';
import '../../../data_sources/manga/manga_data_source.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/common/error_response.dart';
import '../../../models/responses/manga/manga_list_response.dart';

class MangaDataSourceNetwork implements MangaDataSource {
  final Dio dio;

  MangaDataSourceNetwork({required this.dio});

  @override
  Future<MangaListResponse> getMangaList([MangaListParams? params]) async {
    try {
      final Response response = await dio.get(
        HttpUrls.manga,
        queryParameters: params?.toJson(),
      );

      return MangaListResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (dioError) {
      final Map<String, dynamic>? error =
          dioError.error as Map<String, dynamic>?;

      throw ApiException(
        error: error != null ? ErrorResponse.fromJson(error) : null,
      );
    } catch (e) {
      throw ApiException();
    }
  }
}
