import 'package:json_annotation/json_annotation.dart';

part 'label_model.g.dart';

@JsonSerializable(createToJson: false)
class LabelModel {
  ///Contains the english label of a property
  final String? en;

  LabelModel({this.en});

  factory LabelModel.fromJson(Map<String, dynamic> json) =>
      _$LabelModelFromJson(json);
}
