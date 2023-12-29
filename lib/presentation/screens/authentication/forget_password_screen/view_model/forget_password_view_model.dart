import 'dart:async';

import 'package:rababa/domain/usecase/forget_password_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';


class ForgetPasswordViewModel extends BaseViewModel with ForgetPasswordViewModelInput{

  ForgetPasswordUseCase forgetPasswordUseCase ;
  final StreamController<String> forgetPasswordStreamController = BehaviorSubject<String>();
  ForgetPasswordViewModel(this.forgetPasswordUseCase);
  String? _email ;

  @override
  void start() {
   inputState.add(ContentState());
  }
  @override
  void dispose() {
    forgetPasswordStreamController.close();
    super.dispose();
  }

  @override
  forgetPassword() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(_email!=null) {
      (await forgetPasswordUseCase.execute(_email!))
        .fold((failure) {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
    inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successfulSendPasswordEmail));
    });
    }
    else
      {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState,AppStrings.cantEmpty));
      }
  }

  @override
  setEmail(email) {
    _email = email;
  }

}

abstract class ForgetPasswordViewModelInput {
  forgetPassword();
  setEmail(email);
}