import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../data_sources/manga/manga_data_source.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/manga/manga_list_response.dart';

class MangaRemoteDataSource implements MangaDataSource {
  final Dio dio;

  MangaRemoteDataSource({required this.dio});

  @override
  Future<MangaListResponse> getMangaList([MangaListParams? params]) async {
    return ExceptionHandler.api(() async {
      final Response response = await dio.get(
        HttpUrls.manga,
        queryParameters: params?.toJson(),
      );

      return MangaListResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }
}
