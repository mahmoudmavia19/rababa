

import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rababa/data/network/network_info.dart';

main(){
  group('Test Internet Connection', () {

    late NetworkInfo networkInfo  ;
    setUpAll((){
      networkInfo = NetworkInfoImpl(InternetConnectionChecker());
    });

    test('check internet test ', ()async {

      final result = await  networkInfo.isConnected ;

      expect(result, equals(true)) ;

    })  ;


  }) ;
}