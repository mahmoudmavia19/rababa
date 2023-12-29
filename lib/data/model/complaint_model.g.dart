// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintModel _$ComplaintModelFromJson(Map<String, dynamic> json) =>
    ComplaintModel(
      json['id'] as String,
      json['uid'] as String,
      json['suggestion'] as String,
      DateTime.parse(json['dateTime'] as String),
      name: json['name'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ComplaintModelToJson(ComplaintModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'suggestion': instance.suggestion,
      'dateTime': instance.dateTime.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
    };
