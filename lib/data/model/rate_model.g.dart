// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateModel _$RateModelFromJson(Map<String, dynamic> json) => RateModel(
      json['studentId'] as String,
      json['teacherId'] as String,
      (json['rate'] as num).toDouble(),
      json['comment'] as String,
      DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$RateModelToJson(RateModel instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'teacherId': instance.teacherId,
      'rate': instance.rate,
      'date': instance.date.toIso8601String(),
      'comment': instance.comment,
    };
