import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/get_all_users_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../resources/strings_manager.dart';

class GroupViewModel extends BaseViewModel with GroupViewModelInput , GroupViewModelOutput {
  StreamController<List<UserModel>> usersStreamController = BehaviorSubject<List<UserModel>>();
  GetAllUsersUseCase getAllUsersUseCase;

  GroupViewModel(this.getAllUsersUseCase);

  @override
  void start() {
    getAllUsers();
  }
  @override
  void dispose() {
    usersStreamController.close();
    super.dispose();
  }

  @override
  getAllUsers()async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllUsersUseCase.execute(AppConstant.nullVoid())).fold((failure) {
    inputState.add(
    ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
    usersInput.add(data);
    if (data == [] || data!.isEmpty) {
    inputState.add(EmptyState(AppStrings.emptyContent));
    } else {
    inputState.add(ContentState());
    }
    });
  }

  @override
   Sink get usersInput => usersStreamController.sink;

  @override
  Stream<List<UserModel>> get usersOutput =>usersStreamController.stream.map((event) => event);

}

abstract class GroupViewModelOutput {
  Stream<List<UserModel>> get usersOutput;
}

abstract class GroupViewModelInput {
  getAllUsers();
  Sink get usersInput ;
}