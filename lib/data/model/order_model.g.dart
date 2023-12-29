// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderNumber: json['orderNumber'] as String?,
      teacherName: json['teacherName'] as String?,
      studentName: json['studentName'] as String?,
      total: json['total'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      machine: json['machine'] as String?,
      status: json['status'] as String?,
      studentId: json['studentId'] as String?,
      teacherId: json['teacherId'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'teacherName': instance.teacherName,
      'teacherId': instance.teacherId,
      'studentName': instance.studentName,
      'studentId': instance.studentId,
      'date': instance.date?.toIso8601String(),
      'total': instance.total,
      'status': instance.status,
      'machine': instance.machine,
    };
