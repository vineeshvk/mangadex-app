import 'package:dio/dio.dart';

import '../../../core/constants/http_urls.dart';
import '../../../core/constants/manga_constants.dart';
import '../../../core/exception/exception_handler.dart';
import '../../../core/models/model_serialization_helper.dart';
import '../../../core/utils/extensions_util.dart';
import '../../../models/common/base_item_model.dart';
import '../../../models/manga/cover_model.dart';
import '../../../models/master/manga_master_model.dart';
import '../../../models/params/manga/manga_list_params.dart';
import '../../../models/responses/common/base_data_response.dart';
import '../../../models/responses/manga/manga_list_response.dart';
import '../../../models/responses/manga/tag_list_response.dart';

class MangaRemoteDataSource {
  final Dio dio;

  MangaRemoteDataSource({required this.dio});

  Future<List<MangaMasterModel>> getMangaList([MangaListParams? params]) async {
    return ExceptionHandler.api(() async {
      final Response response = await dio.get(
        HttpUrls.manga,
        queryParameters: params?.toJson(),
      );

      final mangaResponse = MangaListResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final Iterable<MangaMasterModel> mangaList =
          mangaResponse.results.map((mangaItem) {
        final mangaModel = MangaMasterModel.fromMangaModel(
          mangaItem.data.attributes,
        );

        mangaModel.coverId = mangaItem.relationships
            .getRelation(MangaRelationshipTypes.coverArt)
            ?.id;

        mangaModel.getCover(dataSource: this);

        return mangaModel;
      });

      return mangaList.toList();
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
