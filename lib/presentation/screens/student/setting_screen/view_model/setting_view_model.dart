import 'dart:async';

import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/domain/usecase/logout_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class SettingViewModel extends BaseViewModel  {

  LogoutUseCase logoutUseCase  = LogoutUseCase(instance());
  StreamController<bool> logoutCon = BehaviorSubject<bool>();

@override
  void dispose() {
    logoutCon.close();
    super.dispose();
  }

  @override
  void start() {

    inputState.add(ContentState());
  }

  logout()async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await logoutUseCase.execute(AppConstant.nullVoid())).fold((l) {
      logoutCon.add(false);
      inputState.add(ErrorState(StateRendererType.popupErrorState,l.message));
    }, (r) {
      logoutCon.add(true);
      inputState.add(ContentState());
    });
  }

}