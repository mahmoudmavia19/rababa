import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'rate_model.g.dart';
@JsonSerializable(explicitToJson: true)
class RateModel extends Equatable{
  String studentId ;
  String teacherId ;
  double rate ;
  DateTime date ;
  String comment ;

  RateModel(this.studentId, this.teacherId, this.rate, this.comment,this.date);

  @override
   List<Object?> get props =>[
    studentId,
    teacherId,
    rate,
    comment
  ];

factory RateModel.fromJson(Map<String, dynamic> json) => _$RateModelFromJson(json);

Map<String, dynamic> toJson() => _$RateModelToJson(this);
}