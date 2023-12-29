
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';

class AppConstant {
  static const String ar = 'AR';
  static const String users = 'Users';
  static const String certificates = 'Certificates';
  static const String certificate = 'certificate';
  static const String posts = 'Posts';
  static const String shops = 'Shops';
  static const String orders = 'Orders';
  static const String lovePosts = 'Love Posts';
  static const String comments = 'Comments';
  static const String suggestions = 'Suggestions';
  static const String postsStacker = 'Posts Stacker';
  static const String cards = 'CreditCards';
  static const String uid = 'uid';
  static const String rate = 'rate';
  static const String raterCount = 'raterCount';
  static const String author = 'author';
  static const String fontFamilyRoboto = 'Roboto';
  static const String empty = '';
  static const String teach = 'teach';
  static const String listen = 'listen';
  static const String learn = 'learn';
  static const String likes = 'likes';
  static const String followers = 'followers';
  static const String following = 'following';
  static const String certificates_2 = 'certificates';
  static const String blockers = 'blockers';
  static const String nay = 'ناي'  ;
  static const String kaman = 'كمان' ;
  static const String qanun = 'قانون';
  static const String oud = 'عود'  ;

  static const String messages = 'messages';
  static const String unseen = 'UnSeen';
  static void nullVoid(){}
  static UserObject? userObject  ;
  static UserType userType = UserType.listen;
  static FilteringTextInputFormatter engREX  =
  FilteringTextInputFormatter.allow(RegExp(r'^[~!@#$%^&*()_+=[\]\\{}|;:".\/<>?a-zA-Z0-9-]+$'));
  static final PageController  pageController = PageController(initialPage: 0);


}
enum UserType{
 learn ,
 teach ,
 listen
}

extension UserTypeString on UserType {
  String userString(){
    switch(this) {
      case UserType.learn:
      return AppConstant.learn ;
      case UserType.teach:
        return AppConstant.teach ;
      case UserType.listen:
        return AppConstant.listen ;
    }
    }
}

extension StringUserType on String {
  UserType userType() {
    switch (this) {
      case AppConstant.learn:
        return UserType.learn;
      case AppConstant.teach:
        return UserType.teach;
      case AppConstant.listen:
        return UserType.listen;
      default :
        return UserType.learn;
    }
  }
}
