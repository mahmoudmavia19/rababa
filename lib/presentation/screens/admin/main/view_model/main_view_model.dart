import 'dart:async';

import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../domain/usecase/logout_usecase.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class AdminMainViewModel extends BaseViewModel{
  LogoutUseCase logoutUseCase  = LogoutUseCase(instance());
  StreamController<bool> logoutCon = BehaviorSubject<bool>();
  @override
  void start() {
    // TODO: implement start
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