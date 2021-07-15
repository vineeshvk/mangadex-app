import 'package:json_annotation/json_annotation.dart';

import '../../../models/common/error_model.dart';

part 'error_response.g.dart';

@JsonSerializable(createToJson: false)
class ErrorResponse {
  String result;
  List<ErrorModel> errors;

  ErrorResponse({
    required this.result,
    required this.errors,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  @override
  String toString() => 'ErrorResponse(result: $result, errors: $errors)';
}
