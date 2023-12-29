import 'dart:async';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/usecase/login_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput , LoginViewModelOutput {

  final StreamController<LoginObject> _streamController =
      BehaviorSubject<LoginObject>();
  final isUserLoggedInSuccessfullyStreamController = BehaviorSubject<bool>();

  LoginUseCase loginUseCase ;

  LoginViewModel(this.loginUseCase);

  LoginObject loginObject = LoginObject('', '') ;

  @override
  void start() {
     inputState.add(ContentState());
  }

  @override
  void dispose() {
    _streamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStreamController => _streamController.sink;

  @override
   Stream<LoginObject> get outputStreamController => _streamController.stream.map((event) => event);


  @override
  setEmail(String email) {
    loginObject = loginObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    loginObject = loginObject.copyWith(password:password);
  }

  @override
  login()async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await loginUseCase.execute(LoginRequest(
         loginObject.email,
        loginObject.password)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(data);

    });
  }


}

abstract class LoginViewModelOutput {
  Stream<LoginObject> get outputStreamController;

}

abstract class LoginViewModelInput {
  login();
   setEmail(String email);
   setPassword(String password);
  Sink get inputStreamController;


}