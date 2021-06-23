import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex/core/constants/manga_constants.dart';

part 'relationship_model.g.dart';

@JsonSerializable(createToJson: false)
class RelationshipModel {
  final String id;
  final MangaRelationshipTypes type;

  RelationshipModel({
    required this.id,
    required this.type,
  });

  factory RelationshipModel.fromJson(Map<String, dynamic> json) =>
      _$RelationshipModelFromJson(json);
}
