import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/add_comment.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/get_all_user_posts_usecase.dart';

class AddCommentViewModel extends BaseViewModel with AddCommentViewModelInput {
  final StreamController<List<PostModel>>  postsStreamController = BehaviorSubject<List<PostModel>>();
  final StreamController<FlowState>  postsState = BehaviorSubject<FlowState>();

  AddCommentUseCase addCommentUseCase;
  GetAllUserPostsUseCase getAllUserPostsUseCase;

  CommentObject commentObject = CommentObject('','','', DateTime.now());

  AddCommentViewModel(this.addCommentUseCase , this.getAllUserPostsUseCase);


  @override
  addComment(PostModel post) async{
   inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   (await addCommentUseCase.execute(AddCommentUseCaseInput(post, CommentModel(
     commentObject.id ,
       AppConstant.userObject!.uid,
     commentObject.comment ,
     commentObject.date
   )))).fold((l){
     inputState.add(ErrorState(StateRendererType.popupErrorState, l.message,));
   }, (r){
     inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));

   });
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  setCommentString(String value) {
    commentObject = commentObject.copyWith(comment: value , date: DateTime.now() ,);
  }
  @override
  getPosts() async{
    postsState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    print(AppConstant.userObject!.uid.toString());
    (await getAllUserPostsUseCase.execute(AppConstant.userObject!.uid!))
        .fold((failure) {
      postsState
          .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      postsStreamController.sink.add(data!) ;
      for (var element in data) {
        print(element.id);
      }

      if(data == [] || data.isEmpty)
      {
        postsState.add(EmptyState(AppStrings.emptyPosts));
      }
      else {
        postsState.add(ContentState());

      }
    });
  }

}

abstract class AddCommentViewModelInput {
  addComment(PostModel post);
  setCommentString(String value);
  getPosts();
}