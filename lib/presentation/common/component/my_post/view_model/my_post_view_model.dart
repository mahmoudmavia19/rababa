import 'dart:async';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/delete_post_usecase.dart';
import 'package:rababa/domain/usecase/isliked_post_usecase.dart';
import 'package:rababa/domain/usecase/love_post_usecase.dart';
import 'package:rababa/domain/usecase/share_post_usecase.dart';
import 'package:rababa/domain/usecase/update_post_usecase.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view/student_user_profile.dart';
import 'package:rxdart/rxdart.dart';

class MyPostViewModel extends BasePostViewModel {
  StreamController<PostModel> postCon = BehaviorSubject<PostModel>();
  SharePostUseCase sharePostUseCase;
  DeletePostUseCase deletePostUseCase;
  UpdatePostUseCase updatePostUseCase;
  IsLikedUseCase isLikedUseCase;
  LovePostUseCase lovePostUseCase;
  bool? isLike = false;
/*
  PostObject postObject = PostObject('', '', '', '', '', 0,false, DateTime.now(), []);
*/
  PostModel? post;

  MyPostViewModel(this.sharePostUseCase, this.deletePostUseCase,
      this.updatePostUseCase, this.isLikedUseCase, this.lovePostUseCase);

  @override
  comment() {
    // TODO: implement comment
    throw UnimplementedError();
  }

  @override
  delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  like() async {
    bool temp = isLike!;
    var temppost = post;
    if (isLike!) {
      post!.likes
          .removeWhere((element) => element == AppConstant.userObject!.uid);

      List<String> listOfLikes = [];
      listOfLikes.addAll(AppConstant.userObject!.likes!.toList());
      listOfLikes.removeWhere((element) => element == post!.id);
      AppConstant.userObject =
          AppConstant.userObject!.copyWith(likes: listOfLikes);
    } else {
      post!.likes.add(AppConstant.userObject!.uid!);
      List<String> listOfLikes = [];
      listOfLikes.addAll(AppConstant.userObject!.likes!.toList());
      listOfLikes.add(post!.id!);
      AppConstant.userObject =
          AppConstant.userObject!.copyWith(likes: listOfLikes);
    }
    isLike = !isLike!;
    postCon.add(post!);

    (await lovePostUseCase.execute(LovePostUseCaseInput(post!, isLike!))).fold(
        (l) {
      isLike = temp;
      postCon.add(temppost!);
    }, (r) {});
  }

  @override
  share() {
    // TODO: implement share
    throw UnimplementedError();
  }

  @override
  isLikedPost() async {
    (await isLikedUseCase.execute(post!.id!)).fold((l) {}, (r) {
      post!.isLiked = r;
      isLike = r;
      postCon.add(post!);
    });
  }

  @override
  start() async {
    postCon.stream.listen((event) {
      post = event;
    });
    await isLikedPost();
  }
}

abstract class BasePostViewModel {
  start();
  share();
  like();
  isLikedPost();
  comment();
  delete();

}
