// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return ErrorResponse(
    result: json['result'] as String,
    errors: (json['errors'] as List<dynamic>)
        .map((e) => ErrorModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  )
    ..response = json['response']
    ..error = json['error'] == null
        ? null
        : ErrorResponse.fromJson(json['error'] as Map<String, dynamic>);
}
