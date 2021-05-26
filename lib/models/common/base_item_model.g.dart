// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseItemModel<T> _$BaseItemModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseItemModel<T>(
    id: json['id'] as String,
    type: json['type'] as String,
    attributes: fromJsonT(json['attributes']),
  );
}
