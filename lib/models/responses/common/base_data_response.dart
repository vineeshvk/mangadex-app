import 'package:json_annotation/json_annotation.dart';

part 'base_data_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseDataResponse<T> {
  String result;
  T data;

  BaseDataResponse({
    required this.result,
    required this.data,
  });

  factory BaseDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) jsonT,
  ) =>
      _$BaseDataResponseFromJson(
        json,
        (object) => jsonT(object! as Map<String, dynamic>),
      );

  @override
  String toString() => 'BaseDataResponse(result: $result, data: $data)';
}
