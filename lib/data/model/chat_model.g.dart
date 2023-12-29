// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      json['message'] as String?,
      json['sender'] as String?,
      json['receiver'] as String?,
      json['isLastMessage'] as bool?,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'message': instance.message,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'isLastMessage': instance.isLastMessage,
      'date': instance.date?.toIso8601String(),
    };
