import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(createToJson: false)
class ErrorModel {
  String id;
  int status;
  String title;
  String detail;

  ErrorModel({
    required this.id,
    required this.status,
    required this.title,
    required this.detail,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  @override
  String toString() {
    return 'ErrorModel(id: $id, status: $status, title: $title, detail: $detail)';
  }
}
