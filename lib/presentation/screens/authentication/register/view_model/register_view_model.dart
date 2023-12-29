import 'dart:async';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/usecase/register_usecase.dart';
import 'package:rababa/domain/usecase/update_profile_usercase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/subjects.dart';

class RegisterViewModel extends BaseViewModel with RegisterModelViewInput , RegisterModelViewOutput {

  final StreamController<RegisterObject> _streamController =
  BehaviorSubject<RegisterObject>();

  final isUserRegisteredInSuccessfullyStreamController = BehaviorSubject<bool>();
  final isUserCompleteSuccessfullyStreamController = BehaviorSubject<bool>();


  RegisterUseCase registerUseCase ;
  UpdateProfileUseCase updateProfileUseCase ;
  RegisterObject registerObject = RegisterObject('', '', '');
  RegisterViewModel(this.registerUseCase , this.updateProfileUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    _streamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    isUserCompleteSuccessfullyStreamController.close();
  }

  @override
  Sink get inputStreamController => _streamController.sink ;

  @override
  Stream<RegisterObject> get outputStreamController =>
      _streamController.stream.map((event) => event);
  @override
  setEmail(String email) {
    registerObject = registerObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    registerObject = registerObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    registerObject = registerObject.copyWith(userName: userName);
  }

  @override
  register()async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    if( registerObject.userName.length<5){
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, AppStrings.atLest5));
    }
    else if( registerObject.password.length<8)
    {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, AppStrings.atLest8));
    }
    else {
      (await registerUseCase.execute(RegisterRequest(
          registerObject.userName,
          registerObject.email,
          registerObject.password)))
          .fold((failure) {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) {

        /*  inputState.add(SuccessState(
    StateRendererType.popupSuccessState, data.name!));*/
        inputState.add(ContentState());
        isUserRegisteredInSuccessfullyStreamController.add(true) ;

      });
    }
  }

  @override
  completeProfile(UserModel user) async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await registerUseCase.execute(RegisterRequest(
      registerObject.userName,
      registerObject.email,
          registerObject.password)))
        .fold((failure) {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
    inputState.add(ContentState());
    isUserCompleteSuccessfullyStreamController.add(true);
    });
  }
}

abstract class RegisterModelViewOutput {
  Stream<RegisterObject> get outputStreamController;

}

abstract class RegisterModelViewInput {
  register();
  setUserName(String userName);
  setEmail(String email);
  setPassword(String password);
  completeProfile(UserModel user);
  Sink get inputStreamController;

}