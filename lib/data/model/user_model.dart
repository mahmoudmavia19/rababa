import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:rababa/data/model/chat_model.dart';

part 'user_model.g.dart';
@JsonSerializable(explicitToJson: true)
class UserModel  extends Equatable{
  String? name ;
  String? username ;
  String? email ;
  String? bio ;
  String? imgUrl ;
  String? uid ;
  String? userType ;
  String? musicInstrument ;
  List<String>? likes ;
  List<String>? followers ;
  List<String>? following ;
  String? country ;
  String? certificate ;
  List<String>? certificates ;
  bool? isAccepted = false ;
  bool? isBlocked ;
  List<String>? blockers ;
  String? price ;
  double? rate ;
  int? raterCount ;
  UserModel(this.name, this.username, this.email, this.bio, this.uid,
      this.likes, this.followers, this.following ,this.userType,
      {this.imgUrl,this.raterCount , this.musicInstrument,this.isAccepted  = false, this.isBlocked = false , this.country , this.certificate , this.certificates , this.price , this.blockers , this.rate} );

  @override
  List<Object?> get props => [
    name, username, email, bio, uid,
    likes, followers, following ,userType,
    imgUrl ,
    country ,
    isAccepted ,
    isBlocked,
    certificate ,
    certificates ,
    blockers ,
    price,
    rate,
    raterCount
  ];



factory UserModel.fromJson(Map<String, dynamic>? json) => _$UserModelFromJson(json!);

Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

class UserMessage {
  UserModel? user ;
  UnSeenMessages? unSeenMessages ;

  UserMessage(this.user, this.unSeenMessages);
}
