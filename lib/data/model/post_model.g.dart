// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      json['id'] as String?,
      json['author'] as String?,
      json['title'] as String?,
      json['postImg'] as String?,
      json['postVideo'] as String?,
      (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      json['isLiked'] as bool?,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      (json['comments'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['fileName'] as String?,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'title': instance.title,
      'postImg': instance.postImg,
      'postVideo': instance.postVideo,
      'fileName': instance.fileName,
      'likes': instance.likes,
      'isLiked': instance.isLiked,
      'date': instance.date?.toIso8601String(),
      'comments': instance.comments,
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      json['id'] as String?,
      json['userId'] as String?,
      json['comment'] as String?,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'comment': instance.comment,
      'date': instance.date?.toIso8601String(),
    };
