import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'suggestion_model.g.dart';
@JsonSerializable(explicitToJson: true)
class SuggestionModel extends Equatable{

  String id ;
  String uid ;
  String suggestion ;
  DateTime dateTime ;


  SuggestionModel(this.id, this.uid, this.suggestion, this.dateTime);

  @override
  List<Object?> get props => [
    id, uid, suggestion, dateTime
  ];

factory SuggestionModel.fromJson(Map<String, dynamic> json) => _$SuggestionModelFromJson(json);

Map<String, dynamic> toJson() => _$SuggestionModelToJson(this);

}