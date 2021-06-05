// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDataResponse<T> _$BaseDataResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseDataResponse<T>(
    result: json['result'] as String,
    data: fromJsonT(json['data']),
  );
}
