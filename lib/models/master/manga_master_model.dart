import '../../core/constants/http_constants.dart';
import '../../data_sources/remote_data/manga/manga_remote_data_source.dart';
import '../common/base_item_model.dart';
import '../manga/cover_model.dart';
import '../manga/manga_model.dart';
import '../responses/common/base_data_response.dart';

class MangaMasterModel {
  String? id;

  String title;
  String? description;

  String originalLanguage;
  String? publicationDemographic;
  String? status;
  int? year;

  String? contentRating;

  List<String?> tags;

  String? createdAt;
  String? updatedAt;

  String? coverId;
  String? coverUrl;

  bool? isInLibrary = false;

  String? lastReadChapterId;

  //TODO: add list of chapters

  MangaMasterModel({
    required this.title,
    required this.tags,
    required this.originalLanguage,
    this.id,
    this.year,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.description,
    this.contentRating,
    this.publicationDemographic,
  });

  factory MangaMasterModel.fromMangaModel(MangaItemModel model) {
    return MangaMasterModel(
      id: model.id,
      contentRating: model.contentRating,
      createdAt: model.createdAt,
      description: model.description.en,
      originalLanguage: model.originalLanguage,
      publicationDemographic: model.publicationDemographic,
      tags: model.tags.map((e) => e.attributes.name.en).toList(),
      status: model.status,
      title: model.title.en ?? "",
      year: model.year,
      updatedAt: model.updatedAt,
    );
  }

  Future<void> getCover({
    required MangaRemoteDataSource dataSource,
  }) async {
    String coverArtUrl = "";
    try {
      if (coverId != null) {
        final BaseDataResponse<BaseItemModel<CoverModel>> coverArt =
            await dataSource.getCover(coverId!);
        final String fileName = coverArt.data.attributes.fileName;

        if (id != null) {
          coverArtUrl = HttpConstants.createCoverUrl(id!, fileName);
        }
      }
    } catch (e) {/* */}

    coverUrl = coverArtUrl;
  }
}
