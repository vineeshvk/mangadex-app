// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse<T> _$DataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return DataResponse<T>(
    result: json['result'] as String,
    data: fromJsonT(json['data']),
    relationships: (json['relationships'] as List<dynamic>?)
        ?.map((e) => RelationshipModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
