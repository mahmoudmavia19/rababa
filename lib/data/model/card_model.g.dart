// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      json['cardNumber'] as String,
      json['cardName'] as String,
      json['cardExMonth'] as String,
      json['cardExYear'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardName': instance.cardName,
      'cardExMonth': instance.cardExMonth,
      'cardExYear': instance.cardExYear,
    };
