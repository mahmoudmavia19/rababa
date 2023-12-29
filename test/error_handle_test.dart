

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rababa/data/network/error_handler.dart';

main(){

  group('Test Error handle ', () {
    late ErrorHandler error ;
    setUpAll(() {
      error = ErrorHandler.handle(FirebaseException(code: DataSource.wrong_password.getString(), plugin: '')) ;
    }) ;

   test('test error handle wrong password error', (){
     final failure = error.failure ;
     print(failure.message) ;
     print(failure.code) ;

     expect(failure.code,equals('101')) ;
   }) ;
  });

}