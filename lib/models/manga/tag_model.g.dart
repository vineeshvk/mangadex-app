// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    name: LabelModel.fromJson(json['name'] as Map<String, dynamic>),
    description:
        LabelModel.fromJson(json['description'] as Map<String, dynamic>),
    group: json['group'] as String,
    version: json['version'] as int,
  );
}
