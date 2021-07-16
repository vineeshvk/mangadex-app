import '../../core/constants/manga_constants.dart';
import '../../core/exception/exception_handler.dart';
import '../../core/utils/extensions_util.dart';
import '../../data_sources/cache/manga/manga_cache_data_source.dart';
import '../../data_sources/remote_data/manga/manga_remote_data_source.dart';
import '../../models/master/manga_master_model.dart';
import '../../models/master/tag_master_model.dart';
import '../../models/params/manga/manga_list_params.dart';
import '../../models/responses/base_response.dart';
import '../../models/responses/manga/manga_list_response.dart';
import '../../models/responses/manga/tag_list_response.dart';

class MangaRepository {
  final MangaRemoteDataSource _remoteDataSource;
  final MangaCacheDataSource? _cacheDataSource;

  MangaRepository({
    required MangaRemoteDataSource mangaDataSource,
    MangaCacheDataSource? mangaCacheDataSource,
  })  : _remoteDataSource = mangaDataSource,
        _cacheDataSource = mangaCacheDataSource;

  Future<BaseResponse<List<MangaMasterModel>>> getMangaList([
    MangaListParams? params,
  ]) async {
    return ExceptionHandler.repo(() async {
      final MangaListResponse mangaResponse =
          await _remoteDataSource.getMangaList(
        params,
      );

      final List<MangaMasterModel> mangaList =
          _convertToMangaMasterList(mangaResponse);

      return BaseResponse(data: mangaList.toList(), pagination: mangaResponse);
    });
  }

  Future<BaseResponse<List<TagMasterModel>>> getTagList() async {
    //TODO: add cached taglist
    return ExceptionHandler.repo(() async {
      final TagListResponse tagListResponse =
          await _remoteDataSource.getTagList();

      final Iterable<TagMasterModel> tagList =
          tagListResponse.tags.map((tagItem) {
        return TagMasterModel(
          id: tagItem.data.id,
          name: tagItem.data.attributes.name.en ?? "",
          group: tagItem.data.attributes.group,
        );
      });

      return BaseResponse(data: tagList.toList());
    });
  }

  List<MangaMasterModel> _convertToMangaMasterList(
      MangaListResponse mangaResponse) {
    final Iterable<MangaMasterModel> mangaList =
        mangaResponse.results.map((mangaItem) {
      final mangaModel = MangaMasterModel.fromMangaModel(
        mangaItem.data.attributes,
      );

      //To fetch the cover url from either remote and cache
      mangaModel.coverId = mangaItem.relationships
          .getRelation(MangaRelationshipTypes.coverArt)
          ?.id;

      mangaModel.getCover(
        dataSource: _remoteDataSource,
        cacheDataSource: _cacheDataSource,
      );

      return mangaModel;
    });

    return mangaList.toList();
  }
}
