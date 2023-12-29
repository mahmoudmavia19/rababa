import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'chat_model.g.dart';
 @JsonSerializable(explicitToJson: true)
class ChatModel extends Equatable {
  String? message ;
  String? sender ;
  String? receiver;
  bool? isLastMessage ;
  DateTime? date ;
  ChatModel(this.message,this.sender , this.receiver ,this.isLastMessage, this.date );



factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);

Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  @override
   List<Object?> get props => [message,sender , receiver ,isLastMessage, date ];
}

class UnSeenMessages extends Equatable {
  //List<ChatModel>? unseen ;
  int? unseen ;
  ChatModel? lastMessage ;
  UnSeenMessages({this.unseen, this.lastMessage});

  @override
   List<Object?> get props =>[unseen , lastMessage];

}