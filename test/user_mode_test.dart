import 'package:flutter_test/flutter_test.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';

main(){
  group('test model', () {
    late UserModel userModel ;
    setUpAll(() {
      userModel = UserModel('nada', 'nada55', 'nada55@gmail.com', 'love music', '265158581', [], [], [], 'learn') ;
    });



    test('test user type function' , (){
      final userType = userModel.userType!.userType();

      expect(userType,equals(UserType.learn));
    });


    test('test to json function' , (){
      final userType = userModel.toJson();
      final expectResult = {
        'name': userModel.name,
        'username': userModel.username,
        'email': userModel.email,
        'bio': userModel.bio,
        'imgUrl': userModel.imgUrl,
        'uid': userModel.uid,
        'userType': userModel.userType,
        'musicInstrument': userModel.musicInstrument,
        'likes': userModel.likes,
        'followers': userModel.followers,
        'following': userModel.following,
        'country': userModel.country,
        'certificate': userModel.certificate,
        'certificates': userModel.certificates,
        'isAccepted': userModel.isAccepted,
        'isBlocked': userModel.isBlocked,
        'blockers': userModel.blockers,
        'price': userModel.price,
        'rate': userModel.rate,
        'raterCount': userModel.raterCount,
      } ;
      expect(userType,equals(expectResult));
    });


  });
}