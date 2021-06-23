import 'package:json_annotation/json_annotation.dart';
import 'package:mangadex/models/common/relationship_model.dart';

part 'base_data_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseDataResponse<T> {
  final String result;
  final T data;
  final List<RelationshipModel>? relationships;

  BaseDataResponse({
    required this.result,
    required this.data,
    required this.relationships,
  });

  factory BaseDataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>? json) jsonT,
  ) =>
      _$BaseDataResponseFromJson(
        json,
        (object) => jsonT(object as Map<String, dynamic>?),
      );

  @override
  String toString() => 'BaseDataResponse(result: $result, data: $data)';
}
