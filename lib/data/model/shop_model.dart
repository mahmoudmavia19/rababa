import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

class ShopModel extends Equatable {

  String? id ;
  GeoPoint? geoPoint ;
  ShopModel(this.id, this.geoPoint);
  @override
   List<Object?> get props => [
     id ,
    geoPoint
  ] ;

factory ShopModel.fromJson(Map<String, dynamic> json) => _$ShopModelFromJson(json);

Map<String, dynamic> toJson() => _$ShopModelToJson(this);

}

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
  json['id'] as String?,
  json['geoPoint'] as GeoPoint?,
);

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
  'id': instance.id,
  'geoPoint': instance.geoPoint,
};
