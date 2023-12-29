import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rababa/data/model/post_model.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(
      String userName,
      String email ,
      String password ,
      ) = _RegisterObject;
}

@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(
      String email ,
      String password ,
      ) = _LoginObject;
}


@freezed
class UserObject with _$UserObject{
  factory UserObject( String? name ,
  String? username ,
  String? email ,
  String? bio ,
  String? imgUrl ,
  String? uid ,
  String? userType ,
  String? musicInstrument ,
  List<String>? likes ,
  List<String>? followers ,
  List<String>? following ,
  String? country ,
  String? certificate ,
  List<String>? certificates ,
  bool? isAccepted  ,
  bool? isBlocked ,
  List<String>? blockers ,
  String? price ,
  double? rate) = _UserObject;
}

@freezed
class PostObject with _$PostObject{
  factory PostObject(
      String? id,
      String? author,
      String? title,
      String? postImg,
      String? postVideo,
      List<String> likes,
      bool? isLiked,
      DateTime date,
      List<String> comments) = _PostObject;
}

@freezed
class CardObject with _$CardObject{
  factory CardObject(
      String? cardNumber,
      String? cardName,
      String? cardExMonth,
      String? cardExYear) = _CardObject;
}

@freezed
class SuggestionObject with _$SuggestionObject{
  factory SuggestionObject(
      String? id,
      String? uid,
      String? suggestion,
      DateTime? dateTime) = _SuggestionObject;
}


@freezed
class CommentObject with _$CommentObject{
  factory CommentObject(
       String id,
      String userId,
      String  comment,
     DateTime  date) = _CommentObject;
}

@freezed
class ShopsObject with _$ShopsObject{
  factory ShopsObject(
       String? id,
        GeoPoint? geoPoint) = _ShopsObject;
}

@freezed
class OrderObject with _$OrderObject{
  factory OrderObject(
  String? orderNumber,
  String? teacherName,
  String? teacherId ,
  String? studentName ,
  String? studentId ,
  DateTime? date ,
  String? total ,
  String? status ,
  String? machine ) = _OrderObject;
}
@freezed
class RaterObject with _$RaterObject{
  factory RaterObject(
  String? studentId ,
  String? teacherId ,
  double? rate ,
  DateTime? date ,
  String? comment , ) = _RaterObject;
}


