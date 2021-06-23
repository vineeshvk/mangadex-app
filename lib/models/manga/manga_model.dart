import 'package:json_annotation/json_annotation.dart';

import '../../core/models/model_serialization_helper.dart';
import '../common/base_item_model.dart';
import '../common/label_model.dart';
import 'tag_model.dart';

part 'manga_model.g.dart';

@JsonSerializable(createToJson: false)
class MangaItemModel {
  String? id;

  final LabelModel title;
  final List<LabelModel> altTitles;
  final LabelModel description;

  final String originalLanguage;
  final String? publicationDemographic;
  final String? status;
  final int? year;

  final String? contentRating;

  @JsonKey(fromJson: ModelHelper.fromJsonBaseItemWithTag)
  final List<BaseItemModel<TagModel>> tags;

  final int version;
  final String createdAt;
  final String updatedAt;

  MangaItemModel({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.originalLanguage,
    required this.publicationDemographic,
    required this.status,
    required this.year,
    required this.contentRating,
    required this.tags,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MangaItemModel.fromJson(Map<String, dynamic> json) =>
      _$MangaItemModelFromJson(json);

  @override
  String toString() {
    return '''
    MangaModel(title: $title, altTitles: $altTitles, 
    description: $description, originalLanguage: $originalLanguage,
    publicationDemographic: $publicationDemographic, status: $status,
    year: $year, contentRating: $contentRating, tags: $tags, version: $version,
    createdAt: $createdAt, updatedAt: $updatedAt)
      ''';
  }
}
