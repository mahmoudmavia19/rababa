import 'package:firebase_auth/firebase_auth.dart';

abstract class LocalDataSource {
  Future<bool?> checkIsLogin();
}

class LocalDataSourceImpl implements LocalDataSource {
  final FirebaseAuth _localFirebaseAuth ;

  LocalDataSourceImpl(this._localFirebaseAuth);

  @override
  Future<bool?> checkIsLogin() async{
    return _localFirebaseAuth.currentUser != null ;
  }

}