import 'package:json_annotation/json_annotation.dart';

part 'cover_model.g.dart';

@JsonSerializable(createToJson: false)
class CoverModel {
  ///Filename which is used to create this cover url
  /// like this:  https://uploads.mangadex.org/covers/{manga.id}/{cover.filename}
  String fileName;

  String createdAt;
  String updatedAt;

  CoverModel({
    required this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CoverModel.fromJson(Map<String, dynamic> json) =>
      _$CoverModelFromJson(json);
}
