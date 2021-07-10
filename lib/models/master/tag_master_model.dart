import 'package:json_annotation/json_annotation.dart';

part 'tag_master_model.g.dart';

@JsonSerializable()
class TagMasterModel {
  String id;
  String name;
  String group;

  TagMasterModel({
    required this.id,
    required this.name,
    required this.group,
  });

  factory TagMasterModel.fromJson(Map<String, dynamic> json) =>
      _$TagMasterModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagMasterModelToJson(this);

  @override
  String toString() => 'TagMasterModel(id: $id, name: $name, group: $group)';
}
