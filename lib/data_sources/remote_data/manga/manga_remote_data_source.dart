import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../core/models/model_serialization_helper.dart';
import '../../../models/common/base_item_model.dart';
import '../../../models/manga/cover_model.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/common/data_response.dart';
import '../../../models/responses/manga/manga_list_response.dart';
import '../../../models/responses/manga/tag_list_response.dart';
import '../../cache/manga/manga_cache_data_source.dart';

typedef CoverResponse = DataResponse<BaseItemModel<CoverModel>>;

class MangaRemoteDataSource {
  final Dio _networkClient;
  final MangaCacheDataSource? _cacheDataSource;

  MangaRemoteDataSource(
      {required Dio networkClient, MangaCacheDataSource? mangaCacheDataSource})
      : _networkClient = networkClient,
        //TODO: establish communication via repository and not direct datasources
        _cacheDataSource = mangaCacheDataSource;

  Future<MangaListResponse> getMangaList([MangaListParams? params]) async {
    return ExceptionHandler.api(() async {
      final Response response = await _networkClient.get(
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
      final Response response = await _networkClient.get(HttpUrls.tags);

      return TagListResponse.fromJson(response.data as List);
    });
  }

  Future<CoverResponse> getCover(String coverId) {
    return ExceptionHandler.api(() async {
      final Response response =
          await _networkClient.get(HttpUrls.cover(coverId));

      return ModelHelper.fromJsonBaseDataWithBaseItemWithCover(
        response.data as Map<String, dynamic>,
      );
    });
  }
}
