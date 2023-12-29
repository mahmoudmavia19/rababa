import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'order_model.g.dart';
@JsonSerializable(explicitToJson: true)
class OrderModel extends Equatable{

  String? orderNumber ;
  String? teacherName ;
  String? teacherId ;
  String? studentName ;
  String? studentId ;
  DateTime? date ;
  String? total ;
  String? status ;
  String? machine ;



  OrderModel(
      {this.orderNumber, this.teacherName, this.studentName, this.total , this.date , this.machine , this.status , this.studentId , this.teacherId});



  @override
  List<Object?> get props => [
    orderNumber,
    teacherName,
    studentName,
    date ,
    total
  ];

factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

Map<String, dynamic> toJson() => _$OrderModelToJson(this);

}