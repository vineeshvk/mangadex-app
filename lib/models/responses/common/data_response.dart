import 'package:json_annotation/json_annotation.dart';

import '../../common/relationship_model.dart';

part 'data_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class DataResponse<T> {
  final String result;
  final T data;
  final List<RelationshipModel>? relationships;

  DataResponse({
    required this.result,
    required this.data,
    this.relationships,
  });

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>? json) jsonT,
  ) =>
      _$DataResponseFromJson(
        json,
        (object) => jsonT(object as Map<String, dynamic>?),
      );

  @override
  String toString() => 'BaseDataResponse(result: $result, data: $data)';
}
