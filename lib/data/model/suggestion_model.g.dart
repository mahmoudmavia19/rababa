// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionModel _$SuggestionModelFromJson(Map<String, dynamic> json) =>
    SuggestionModel(
      json['id'] as String,
      json['uid'] as String,
      json['suggestion'] as String,
      DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$SuggestionModelToJson(SuggestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'suggestion': instance.suggestion,
      'dateTime': instance.dateTime.toIso8601String(),
    };
