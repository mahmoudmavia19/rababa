import 'dart:async';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/delete_post_usecase.dart';
import 'package:rababa/domain/usecase/share_post_usecase.dart';
import 'package:rababa/domain/usecase/update_post_usecase.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../app/end_points/constant.dart';
import '../../../../domain/usecase/isliked_post_usecase.dart';
import '../../../../domain/usecase/list_to_post_usease.dart';
import '../../../../domain/usecase/love_post_usecase.dart';
import '../my_post/view_model/my_post_view_model.dart';

class UserPostViewModel extends BasePostViewModel with UserPostViewModelInput {

  StreamController<PostModel> postCon = BehaviorSubject<PostModel>();
  SharePostUseCase sharePostUseCase ;
  UpdatePostUseCase updatePostUseCase ;
  IsLikedUseCase isLikedUseCase ;
  LovePostUseCase lovePostUseCase ;
  ListToPostUseCase listToPostUseCase ;
/*
  PostObject postObject = PostObject('', '', '', '', '', 0,false, DateTime.now(), []);
*/
  PostModel? post ;

  bool? isLike = false;

  UserPostViewModel(
      this.sharePostUseCase, this.updatePostUseCase , this.isLikedUseCase, this.lovePostUseCase, this.listToPostUseCase);

  @override
  comment() {
    // TODO: implement comment
    throw UnimplementedError();
  }


  @override
  like()async{
    bool temp = isLike!;
    if(isLike!)
    {
      post!.likes.removeWhere((element) => element ==AppConstant.userObject!.uid);
    }
    else
    {
      post!.likes.add(AppConstant.userObject!.uid!) ;
    }
    isLike = !isLike! ;
    postCon.add(post!);
    (await updatePostUseCase.execute(post!)).fold((l) {
      isLike = temp ;
      postCon.add(post!);
    },
            (r){
        });
    (await lovePostUseCase.execute(LovePostUseCaseInput(post!, isLike!))).fold((l) => print(l.message),
            (r) => print('success'));
  }

  @override
  share() {
    // TODO: implement share
    throw UnimplementedError();
  }

  @override
  delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  isLikedPost()async{
    (await isLikedUseCase.execute(post!.id!)).fold((l) {},
            (r) {
          post!.isLiked = r ;
          isLike = r;
          print(r);
          postCon.add(post!) ;
        }) ;
  }
  @override
  start()async {

    postCon.stream.listen((event) {
      post = event ;
    }) ;

   await isLikedPost();
    listenToPost();
  }

  @override
  listenToPost() async{
    (await listToPostUseCase.execute(post!)).fold((l){}, (r) {
      r?.listen((event) {
        isLikedPost();
        postCon.add(PostModel.fromJson(event.data()!)) ;
      });
    });
  }


}

abstract class UserPostViewModelInput {
  listenToPost();
}


