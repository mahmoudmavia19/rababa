
import 'package:json_annotation/json_annotation.dart';

class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

