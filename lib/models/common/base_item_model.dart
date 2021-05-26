import 'package:json_annotation/json_annotation.dart';

part 'base_item_model.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseItemModel<T> {
  final String id;
  final String type;

  final T attributes;

  BaseItemModel({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory BaseItemModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) jsonT,
  ) =>
      _$BaseItemModelFromJson(
        json,
        (json) => jsonT(json! as Map<String, dynamic>),
      );

  @override
  String toString() => 'BaseItemModel(id: $id, type: $type, attributes: $attributes)';
}
