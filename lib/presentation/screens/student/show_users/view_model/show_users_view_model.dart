import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/get_list_of_users_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class ShowUsersViewModel extends BaseViewModel with ShowUsersViewModelInput , ShowUsersViewModelOutput {
  final StreamController<List<UserModel>> _controller = BehaviorSubject<List<UserModel>>() ;
  GetListOfUsersUseCase getListOfUsersUseCase ;

  ShowUsersViewModel(this.getListOfUsersUseCase);

  @override
  void start() {
   }

  @override
  getListOfUsers(List<String>usersId) async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
  (await getListOfUsersUseCase.execute(usersId)).fold((l) {
    inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message)) ;
  }, (r){
    usersInput.add(r) ;
    if(r.isEmpty){
      inputState.add(EmptyState('')) ;
    }
    else {
      inputState.add(ContentState()) ;
    }
  }) ;
  }

  @override
   Sink get usersInput => _controller.sink;

  @override
   Stream<List<UserModel>> get usersOutput => _controller.stream.map((event) => event) ;

}

abstract class ShowUsersViewModelOutput {
  Stream<List<UserModel>> get usersOutput ;
}

abstract class ShowUsersViewModelInput {
  getListOfUsers(List<String>usersId);
  Sink get usersInput ;
}