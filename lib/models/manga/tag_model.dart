import 'package:json_annotation/json_annotation.dart';

import '../common/label_model.dart';

part 'tag_model.g.dart';

@JsonSerializable(createToJson: false)
class TagModel {
  final LabelModel name;
  final LabelModel description;

  final String group;
  final int version;

  TagModel({
    required this.name,
    required this.description,
    required this.group,
    required this.version,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
