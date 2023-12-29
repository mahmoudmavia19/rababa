import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/usecase/reset_password_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/login_usecase.dart';

class ResetPasswordViewModel extends BaseViewModel  with ResetPasswordViewModelInput ,ResetPasswordViewModelOutput {
  String? oldPassword ;
  String? newPassword ;
  String? rePassword ;

  ResetPasswordUseCase resetPasswordUseCase ;
  LoginUseCase loginUseCase ;


  ResetPasswordViewModel(this.resetPasswordUseCase , this.loginUseCase);

  @override
  void start() {
  inputState.add(ContentState());
  }


  @override
  changePassword() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(newPassword !=null && rePassword !=null && oldPassword !=null )
      {
        if(newPassword==rePassword)
          {
            (await loginUseCase.execute(LoginRequest(AppConstant.userObject!.email!, oldPassword!))).fold((l){
              inputState.add(ErrorState(StateRendererType.popupErrorState ,l.message));

            }, (r) async{
              (await resetPasswordUseCase.execute(newPassword!)).fold((l) {
              inputState.add(ErrorState(StateRendererType.popupErrorState ,l.message));
              }, (r) {
              inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successfulSaved));
              });
            }) ;


          }else {
          inputState.add(ErrorState(StateRendererType.popupErrorState ,AppStrings.passwordNotMatch));
        }
      }
    else{
      inputState.add(ErrorState(StateRendererType.popupErrorState ,AppStrings.cantEmpty));
    }
  }


}

abstract class ResetPasswordViewModelOutput {

}

abstract class ResetPasswordViewModelInput {
  changePassword();
}