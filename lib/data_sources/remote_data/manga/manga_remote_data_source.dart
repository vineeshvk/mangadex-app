import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../core/models/model_serialization_helper.dart';
import '../../../models/common/base_item_model.dart';
import '../../../models/manga/cover_model.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/common/base_data_response.dart';
import '../../../models/responses/manga/manga_list_response.dart';
import '../../../models/responses/manga/tag_list_response.dart';
import '../../cache/manga/manga_cache_data_source.dart';

class MangaRemoteDataSource {
  final Dio dio;
  final MangaCacheDataSource? _cacheDataSource;

  MangaRemoteDataSource(
      {required this.dio, MangaCacheDataSource? mangaCacheDataSource})
      : _cacheDataSource = mangaCacheDataSource;

  Future<MangaListResponse> getMangaList([MangaListParams? params]) async {
    return ExceptionHandler.api(() async {
      final Response response = await dio.get(
        HttpUrls.manga,
        queryParameters: params?.toJson(),
      );

      final mangaResponse = MangaListResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      return mangaResponse;
    });
  }

  Future<TagListResponse> getTagList() {
    return ExceptionHandler.api(() async {
      final Response response = await dio.get(HttpUrls.tags);

      return TagListResponse.fromJson(response.data as List);
    });
  }

  Future<BaseDataResponse<BaseItemModel<CoverModel>>> getCover(String coverId) {
    return ExceptionHandler.api(() async {
      final Response response = await dio.get(HttpUrls.cover(coverId));

      return ModelHelper.fromJsonBaseDataWithBaseItemWithCover(
        response.data as Map<String, dynamic>,
      );
    });
  }
}
