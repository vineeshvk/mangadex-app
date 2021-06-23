import 'package:json_annotation/json_annotation.dart';

import '../../core/constants/manga_constants.dart';

part 'base_item_model.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseItemModel<T> {
  final String id;
  final MangaRelationshipTypes type;

  final T attributes;

  BaseItemModel({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory BaseItemModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json, String id) jsonT,
  ) =>
      _$BaseItemModelFromJson(
        json,
        (json2) => jsonT(json2! as Map<String, dynamic>, json["id"].toString()),
      );

  @override
  String toString() =>
      'BaseItemModel(id: $id, type: $type, attributes: $attributes)';
}
