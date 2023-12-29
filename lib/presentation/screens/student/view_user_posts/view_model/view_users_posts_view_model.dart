import 'dart:async';

import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/get_all_user_posts_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/end_points/constant.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../resources/strings_manager.dart';

class ViewUsersPostsViewModel extends BaseViewModel  with  ViewUsersPostsViewModelInput , ViewUsersPostsViewModelOutput{

  final StreamController<List<PostModel>> _postsStreamController = BehaviorSubject<List<PostModel>>() ;

  GetAllUserPostsUseCase getAllUserPostsUseCase;


  ViewUsersPostsViewModel(this.getAllUserPostsUseCase);

  @override
  Sink<List<PostModel>> get postsInput => _postsStreamController.sink;

  @override
  Stream<List<PostModel>> get postsOutput =>_postsStreamController.stream.map((event) => event);

  @override
  void start() {
  }

  @override
  getPosts(String uid) async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    print(AppConstant.userObject!.uid.toString());
    (await getAllUserPostsUseCase.execute(uid))
        .fold((failure) {
      inputState
        .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
    postsInput.add(data!) ;
    for (var element in data) {
    print(element.id);
    }

    if(data == [] || data.isEmpty)
    {
    inputState.add(EmptyState(AppStrings.emptyPosts));
    }
    else {
      inputState.add(ContentState());

    }
    });
  }


}

abstract class ViewUsersPostsViewModelOutput {
  Stream<List<PostModel>> get postsOutput ;
}

abstract class ViewUsersPostsViewModelInput {
  getPosts(String uid);
  Sink<List<PostModel>> get postsInput;
}
