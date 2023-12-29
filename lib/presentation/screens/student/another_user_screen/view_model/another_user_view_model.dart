import 'dart:async';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/block_user_usecase.dart';
import 'package:rababa/domain/usecase/follow_user_usecase.dart';
import 'package:rababa/domain/usecase/get_all_user_posts_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/model/post_model.dart';

class AnotherUserViewModel extends BaseViewModel with AnotherUserViewModelInput{

  StreamController<bool> isFollowing = BehaviorSubject<bool>();
  StreamController<bool> isBlocking = BehaviorSubject<bool>();
  StreamController<List<PostModel>?> userPosts = BehaviorSubject<List<PostModel>?>();
  FollowUseCase followUseCase ;
  BlockUserUseCase blockUserUseCase ;
  GetAllUserPostsUseCase getAllUserPostsUseCase ;
   bool isFollowed = false ;
   bool isBlocked = false ;
   UserModel? userModel ;
  AnotherUserViewModel(this.followUseCase , this.blockUserUseCase,this.getAllUserPostsUseCase  , this.userModel) ;

  @override
  void start() {
    isFollowed = isFollowBool();
    isFollowing.add(isFollowed);
    isBlocked = isBlockedBool();
    isBlocking.add(isBlocked);

  }

  @override
  following() async{
    isFollowed = !isFollowed ;
    (await followUseCase.execute(FollowUseCaseInput(isFollowed, userModel!.uid!))).fold((l){
     // inputState.add(ErrorState(StateRendererType.popupErrorState,l.message));

    }, (r)
    {
      isFollowing.add(isFollowed);
      List<String> list = AppConstant.userObject!.following!.map((e) => e).toList();
      if(isFollowed){
        list.add(userModel!.uid!);
        userModel!.followers!.add(AppConstant.userObject!.uid!);
      }
      else {
        list.removeWhere((element) => element==userModel!.uid!);
        userModel!.followers!.removeWhere((element) => element==AppConstant.userObject!.uid!);
      }
      AppConstant.userObject =   AppConstant.userObject!.copyWith(following: list);
      //inputState.add(SuccessState(StateRendererType.popupSuccessState,''));
    }
    ) ;

  }

  @override
  bool isFollowBool() {
    isFollowed =  AppConstant.userObject!.following!.contains(userModel!.uid!);
    print(" is follow $isFollowed");
     return isFollowed;
  }

  @override
  blocking() async{
    isBlocked = !isBlocked ;
    (await blockUserUseCase.execute(BlockUserUseCaseInput(userModel!.uid!,isBlocked))).fold((l){
      // inputState.add(ErrorState(StateRendererType.popupErrorState,l.message));

    }, (r)
    {
      isBlocking.add(isBlocked);
      List<String> list = AppConstant.userObject!.blockers!.map((e) => e).toList();
      if(isBlocked){
        list.add(userModel!.uid!);
       }
      else {
        list.removeWhere((element) => element==userModel!.uid!);
       }
      AppConstant.userObject =   AppConstant.userObject!.copyWith(blockers: list);
      print(AppConstant.userObject!.blockers) ;
      print(list) ;
      //inputState.add(SuccessState(StateRendererType.popupSuccessState,''));
    }
    ) ;

  }

  @override
  bool isBlockedBool() {
    isBlocked = AppConstant.userObject!.blockers!=null?  AppConstant.userObject!.blockers!.contains(userModel!.uid!) : false;
    print(" is blocked $isBlocked");
    return isBlocked;
  }

  @override
  getUserPosts() async{
      inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
      (await getAllUserPostsUseCase.execute(userModel!.uid!)).fold(
              (l) {
                inputState.add(ErrorState(StateRendererType.fullScreenErrorState,l.message)) ;
              },
              (r) {
                print('posts of user lenght ${r!.length}') ;
                userPosts.sink.add(r) ;
                inputState.add(ContentState()) ;
              });
    }


}

abstract class AnotherUserViewModelInput {
  following();
  blocking();
  getUserPosts();
  bool isFollowBool();
  bool isBlockedBool();
}