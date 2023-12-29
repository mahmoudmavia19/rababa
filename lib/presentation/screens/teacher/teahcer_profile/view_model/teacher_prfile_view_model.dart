import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../../data/model/rate_model.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../../domain/usecase/delete_post_usecase.dart';
import '../../../../../domain/usecase/get_all_love_posts_usecase.dart';
import '../../../../../domain/usecase/get_all_user_posts_usecase.dart';
import '../../../../../domain/usecase/get_profile_usecase.dart';
import '../../../../../domain/usecase/get_rating_teacher_usecase.dart';
import '../../../../../domain/usecase/update_profile_usercase.dart';
import '../../../../../domain/usecase/upload_img_usecase.dart';
import '../../../../common/freezed_data_classes.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/strings_manager.dart';

class
TeacherMainProfileViewModel extends BaseViewModel with TeacherMainProfileViewModelInput , TeacherMainProfileViewModelOutput {
  final StreamController<UserModel>   userStreamController = BehaviorSubject<UserModel>();
  final StreamController<List<PostModel>>  postsStreamController = BehaviorSubject<List<PostModel>>();
  final StreamController<List<PostModel>>  lovePostsStreamController = BehaviorSubject<List<PostModel>>();
  final StreamController<FlowState>  postsState = BehaviorSubject<FlowState>();
  final StreamController<String?>   musicMachine = BehaviorSubject<String>();
  StreamController<List<RateModel>> ratesStream = BehaviorSubject<List<RateModel>>();
  double rate = 0.0 ;
/*
  final StreamController<FlowState>  postsLoveState = BehaviorSubject<FlowState>();
*/
  final StreamController<XFile?>   imgStreamController = BehaviorSubject<XFile?>();
  GetRatingTeacherUseCase getRatingTeacherUseCase;
  GetProfileUseCase getProfileUseCase ;
  GetAllUserPostsUseCase getAllUserPostsUseCase;
  DeletePostUseCase deletePostUseCase ;
  GetAllLovePostsUseCase getAllLovePostsUseCase ;
  UpdateProfileUseCase updateProfileUseCase ;
  UploadFileToFirebaseUseCase uploadImgUseCase ;
  File? img ;
  var user = AppConstant.userObject!;
  TeacherMainProfileViewModel(this.getProfileUseCase , this.getAllUserPostsUseCase , this.deletePostUseCase, this.getAllLovePostsUseCase,this.updateProfileUseCase,this.uploadImgUseCase,this.getRatingTeacherUseCase);
  bool postDelete = false ;
  @override
  void start() {
    getProfile() ;
    getPosts();
    getLovePosts();
    musicMachine.add(user.musicInstrument ?? '') ;

  }

  @override
  void dispose() {
    userStreamController.close();
    postsStreamController.close();
    postsState.close();
/*
    postsLoveState.close();
*/
    super.dispose();
  }


  @override
  getProfile()async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getProfileUseCase.execute(AppConstant.nullVoid()))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      data.listen((event) {
        UserModel user = UserModel.fromJson(event.data());
        userInput.add(user) ;
        AppConstant.userObject =  UserObject(
            user.name,
            user.username ,
            user.email ,
            user.bio ,
            user.imgUrl ,
            user.uid ,
            user.userType ,
            user.musicInstrument ,
            user. likes ,
            user. followers ,
            user. following ,
            user.country ,
            user.certificate ,
            user.certificates ,
            user.isAccepted  ,
            user.isBlocked ,
            user.blockers ,
            user. price ,
            user. rate
        ) ;
      });
      inputState.add(ContentState());
    });
  }

  @override
  updateProfile() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(img!=null)
    {
      (await uploadImgUseCase.execute(UploadFileToFirebaseUseCaseInput(img!,AppConstant.users,AppConstant.userObject!.uid!,)))
          .fold((failure) {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) async{
        (await updateProfileUseCase.execute(
            UserModel(user.name,
                user.username,user. email,
                user.bio, user.uid,
                user.likes,user. followers,user.following,user.userType ,
                imgUrl: data,
                musicInstrument:user.musicInstrument ,
                blockers: user.blockers ,
                certificate:  user.certificate ,
                isBlocked: user.isBlocked,
                isAccepted: user.isAccepted,
                country: user.country,
                certificates: user.certificates,
                price:  user.price,
                rate:   user.rate)
        ))
            .fold((failure) {
          inputState
              .add(ErrorState(StateRendererType.popupErrorState, failure.message));
        }, (data) async{
          inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.edit));
          userInput.add(data) ;
        });
      });
    }else {
      (await updateProfileUseCase.execute(
          UserModel(user.name,
              user.username,user. email,
              user.bio, user.uid,
              user.likes,user. followers,user.following,user.userType ,
              imgUrl: user.imgUrl,
              musicInstrument:user.musicInstrument ,
              blockers: user.blockers ,
              certificate:  user.certificate ,
              isBlocked: user.isBlocked,
              isAccepted: user.isAccepted,
              country: user.country,
              certificates: user.certificates,
              price:  user.price,
              rate:   user.rate)))
          .fold((failure) {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) async{
        inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.edit));
        userInput.add(data) ;
      });
    }
  }
  @override
  Sink get userInput => userStreamController.sink;

  @override
  Stream<UserModel?> get userOutput =>userStreamController.stream.map((event) => event) ;

  @override
  getPosts() async{
    /*  postsState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));*/
    print(AppConstant.userObject!.uid.toString());
    (await getAllUserPostsUseCase.execute(AppConstant.userObject!.uid!))
        .fold((failure) {
      postsState
          .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      postsInput.add(data) ;
      for (var element in data!) {
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

  @override
  Sink get postsInput => postsStreamController.sink;

  @override
  Stream<List<PostModel>?> get postsOutput =>postsStreamController.stream.map((event) => event);

  @override
  deletePost(PostModel post)async{
    postDelete = true ;
    postsState
        .add(DeletingState(message:AppStrings.deletePost));
    (await deletePostUseCase.execute(post))
        .fold((failure) {
      postsState
          .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      postsState
          .add(ContentState());
      getPosts();

    });
  }

  @override
  getLovePosts() async{
    /*postsLoveState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));*/
    print(AppConstant.userObject!.uid.toString());
    (await getAllLovePostsUseCase.execute(AppConstant.nullVoid()))
        .fold((failure) {
      /*postsLoveState
          .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));*/
    }, (data) {
      lovePostsInput.add(data) ;
      for (var element in data!) {
        print(element.id);
      }

      if(data == [] || data.isEmpty)
      {
/*
        postsLoveState.add(EmptyState(AppStrings.emptyPosts));
*/
      }
      else {
/*
        postsLoveState.add(ContentState());
*/

      }
    });
  }

  @override
  Sink get lovePostsInput => lovePostsStreamController.sink;

  @override
  Stream<List<PostModel>?> get lovePostsOutput => lovePostsStreamController.stream.map((event) => event);

  @override
  setImg() async{
    final image = await  ImagePicker().pickImage(source: ImageSource.gallery);
    imgStreamController.add(image);
    img =  File(image!.path) ;
  }

  @override
  setName(name) {
    user = user.copyWith(name:name) ;
  }

  @override
  setUserName(username) {
    user = user.copyWith(username:username) ;
  }
  @override
  toggle(String machine) {
    user = user.copyWith(musicInstrument:machine) ;
    musicMachine.sink.add(machine);
  }

  @override
  updatePrice(String price) {
    user = user.copyWith(price:price) ;
  }
  @override
  setBio(bio) {
    user = user.copyWith(bio:bio) ;
  }

  @override
  setCountry(country) {
    user = user.copyWith(country:country) ;
  }

  @override
  getRate() async{
    (await getRatingTeacherUseCase.execute(user.uid!)).fold((l) {

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

abstract class TeacherMainProfileViewModelOutput {
  Stream <UserModel?> get userOutput ;
  Stream<List<PostModel>?> get postsOutput ;
  Stream<List<PostModel>?> get lovePostsOutput ;
}

abstract class TeacherMainProfileViewModelInput {
  updateProfile();
  setBio(bio);
  setUserName(username);
  setImg();
  setName(name);
  setCountry(country);
  toggle(String machine);
  updatePrice(String price);

  getProfile();
  getPosts();
  getLovePosts();
  deletePost(PostModel post);
  Sink  get  postsInput ;
  Sink  get  lovePostsInput ;
  Sink  get  userInput ;

  getRate();
  calRate(List<RateModel> items);

}