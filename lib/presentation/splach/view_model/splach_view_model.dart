import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/domain/usecase/check_login_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class SplashViewModel extends BaseViewModel with  SplashViewModelInput{

  StreamController<bool?> checkLoginStream  = BehaviorSubject<bool?>() ;
  CheckLoginUseCase checkLoginUseCase ;


  SplashViewModel(this.checkLoginUseCase);

  @override
  void start() {
    checkIsLogin();
  }
  @override
  void dispose() {
    checkLoginStream.close() ;
    super.dispose();
  }
  @override
  checkIsLogin() async{
    (await checkLoginUseCase.execute(AppConstant.nullVoid())).fold((l) {

    }, (r) {
         checkLoginStream.sink.add(r);
    }) ;
  }

}

abstract class SplashViewModelInput {
 checkIsLogin();
}