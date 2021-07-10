// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagMasterModel _$TagMasterModelFromJson(Map<String, dynamic> json) {
  return TagMasterModel(
    id: json['id'] as String,
    name: json['name'] as String,
    group: json['group'] as String,
  );
}

Map<String, dynamic> _$TagMasterModelToJson(TagMasterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'group': instance.group,
    };
