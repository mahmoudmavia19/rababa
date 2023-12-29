import 'dart:async';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/rate_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/follow_user_usecase.dart';
import 'package:rababa/domain/usecase/get_all_user_posts_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/block_user_usecase.dart';
import '../../../../../domain/usecase/get_rating_teacher_usecase.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class TeacherProfileViewModel extends BaseViewModel with TeacherProfileViewModelInput , TeacherProfileViewModelOutput{

  StreamController<bool> isFollowing = BehaviorSubject<bool>();
  StreamController<bool> isBlocking = BehaviorSubject<bool>();
  BlockUserUseCase blockUserUseCase ;
  GetRatingTeacherUseCase getRatingTeacherUseCase;
  StreamController<List<PostModel>> postsStream = BehaviorSubject<List<PostModel>>();
  StreamController<List<RateModel>> ratesStream = BehaviorSubject<List<RateModel>>();
  bool isBlocked = false ;
  double rate = 0.0 ;
  FollowUseCase followUseCase ;
  GetAllUserPostsUseCase getAllUserPostsUseCase;
  bool isFollowed = false ;
  UserModel? userModel ;
  TeacherProfileViewModel(this.followUseCase , this.getAllUserPostsUseCase,this.blockUserUseCase , this.getRatingTeacherUseCase,this.userModel) ;

  @override
  void start() {
    getTeacherPosts();
    getRate();
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
  getTeacherPosts() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllUserPostsUseCase.execute(userModel!.uid!)).fold((l) {
      inputState.add(ErrorState(StateRendererType.popupErrorState,l.message));
    }, (r)
    {
      if(r==null || r == []){
        inputState.add(EmptyState(AppStrings.emptyPosts));
      }else {
        teacherPostInput.add(r) ;
        inputState.add(ContentState());
      }
      
    }
    );
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
   Sink get teacherPostInput => postsStream.sink;

  @override
   Stream<List<PostModel>> get teacherPostsOutput => postsStream.stream.map((event) => event);

  @override
  getRate() async{
    (await getRatingTeacherUseCase.execute(userModel!.uid!)).fold((l) {

    }, (r) {
      print(r);
      calRate(r);
      ratesStream.sink.add(r);
    });
  }

  @override
  calRate(List<RateModel> items) {
    if(items.isNotEmpty) {
      for (var item in items) {
        rate += item.rate;
      }
      rate = rate / items.length;
    }else {
      rate = 0.0 ;
    }
  }

}

abstract class TeacherProfileViewModelOutput {
  Stream<List<PostModel>> get teacherPostsOutput ;
}

abstract class TeacherProfileViewModelInput {
  following();
  getTeacherPosts();
  Sink get teacherPostInput ;
  bool isFollowBool();
  bool isBlockedBool() ;
  blocking() ;
  getRate();
  calRate(List<RateModel> items);
}