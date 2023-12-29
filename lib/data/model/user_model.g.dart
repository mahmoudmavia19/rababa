// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['name'] as String?,
      json['username'] as String?,
      json['email'] as String?,
      json['bio'] as String?,
      json['uid'] as String?,
      (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['followers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['following'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['userType'] as String?,
      imgUrl: json['imgUrl'] as String?,
      raterCount: json['raterCount'] as int?,
      musicInstrument: json['musicInstrument'] as String?,
      isAccepted: json['isAccepted'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      country: json['country'] as String?,
      certificate: json['certificate'] as String?,
      certificates: (json['certificates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as String?,
      blockers: (json['blockers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rate: (json['rate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'bio': instance.bio,
      'imgUrl': instance.imgUrl,
      'uid': instance.uid,
      'userType': instance.userType,
      'musicInstrument': instance.musicInstrument,
      'likes': instance.likes,
      'followers': instance.followers,
      'following': instance.following,
      'country': instance.country,
      'certificate': instance.certificate,
      'certificates': instance.certificates,
      'isAccepted': instance.isAccepted,
      'isBlocked': instance.isBlocked,
      'blockers': instance.blockers,
      'price': instance.price,
      'rate': instance.rate,
      'raterCount': instance.raterCount,
    };
