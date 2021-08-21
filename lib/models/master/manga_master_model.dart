import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/constants/http_constants.dart';
import '../../data_sources/cache/manga/manga_cache_data_source.dart';
import '../../data_sources/remote_data/manga/manga_remote_data_source.dart';
import '../manga/manga_item_model.dart';
import 'chapter_master_model.dart';

part 'manga_master_model.g.dart';

@JsonSerializable()
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
  final ValueNotifier<String?> _coverUrl = ValueNotifier(null);

  bool? isInLibrary = false;

  String? lastReadChapterId;

  ValueNotifier<String?> get coverUrlListener => _coverUrl;

  @JsonKey(name: "coverUrl")
  String? get coverUrl => _coverUrl.value;

  @JsonKey(name: "coverUrl")
  set coverUrl(String? url) => _coverUrl.value = url ?? "";

  @JsonKey(ignore: true)
  List<ChapterMasterModel> chapters = [];

  List<PagePresenter> get chapterPresenter {
    /// The `PagePresenter.end()` is to indicate the beginning of the manga.
    final List<PagePresenter> presenters = [PagePresenter.end()];

    for (int index = 0; index < chapters.length; index++) {
      final chapter = chapters[index];

      presenters.addAll(chapter.pagePresenter);

      // if it's not the beginning or the ending then add the title card
      if (index != chapters.length - 1) {
        presenters.add(
          PagePresenter.titleCard(
            chapterTitle: [chapter, chapters[index + 1]],
          ),
        );
      }
    }

    /// To indicate the end of the manga.
    presenters.add(PagePresenter.end());

    return presenters;
  }

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

  // TODO: move the logic to a repository
  Future<void> getCover({
    required MangaRemoteDataSource dataSource,
    MangaCacheDataSource? cacheDataSource,
  }) async {
    String coverArtUrl = "";

    if (cacheDataSource != null) {
      try {
        final String? coverArtCache =
            await cacheDataSource.getMangaCoverArt(this);
        coverArtUrl = coverArtCache ?? "";
      } catch (e) {/* */}
    }

    try {
      if (coverId != null && coverArtUrl.isEmpty) {
        final CoverResponse coverArt = await dataSource.getCover(coverId!);
        final String fileName = coverArt.data.attributes.fileName;

        if (id != null) {
          coverArtUrl = HttpConstants.createCoverUrl(id!, fileName);
        }
      }
    } catch (e) {/* */}

    _coverUrl.value = coverArtUrl;
  }

  factory MangaMasterModel.fromJson(Map<String, dynamic> json) =>
      _$MangaMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaMasterModelToJson(this);

  @override
  String toString() {
    return 'MangaMasterModel(id: $id, title: $title, description: ${description?.substring(0, 10)}, originalLanguage: $originalLanguage, publicationDemographic: $publicationDemographic, status: $status, year: $year, contentRating: $contentRating, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, coverId: $coverId, coverUrl: $coverUrl, isInLibrary: $isInLibrary, lastReadChapterId: $lastReadChapterId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MangaMasterModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
