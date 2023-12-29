import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:rababa/data/model/suggestion_model.dart';

part 'complaint_model.g.dart';
@JsonSerializable(explicitToJson: true)
class ComplaintModel extends  SuggestionModel {
@JsonSerializable(explicitToJson: true)

  String? name ;
  String? email ;

  ComplaintModel(super.id, super.uid, super.suggestion, super.dateTime, {this.name, this.email});



factory ComplaintModel.fromJson(Map<String, dynamic> json) => _$ComplaintModelFromJson(json);

@override
  Map<String, dynamic> toJson() => _$ComplaintModelToJson(this);
}