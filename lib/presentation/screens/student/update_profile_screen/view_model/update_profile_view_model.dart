import 'dart:async';
import 'dart:io';
 import 'package:image_picker/image_picker.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/update_profile_usercase.dart';
import 'package:rababa/domain/usecase/upload_img_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view/student_user_profile.dart';
 import 'package:rxdart/rxdart.dart';


class UpdateProfileViewModel extends BaseViewModel with UpdateProfileViewModelInput , UpdateProfileViewModelOutput {
  final StreamController<UserModel>   userStreamController = BehaviorSubject<UserModel>();
  final StreamController<XFile?>   imgStreamController = BehaviorSubject<XFile?>();
  final StreamController<String?>   musicMachine = BehaviorSubject<String>();
  UpdateProfileUseCase updateProfileUseCase ;
  UploadFileToFirebaseUseCase uploadImgUseCase ;
  File? img ;
   var user = AppConstant.userObject!;
  @override
  void start() {
     print('-------------------${user.name}---------');
     inputState.add(ContentState());
     musicMachine.add(user.musicInstrument ?? '') ;
  }

  UpdateProfileViewModel(this.updateProfileUseCase ,this.uploadImgUseCase);

  @override
  updateProfile() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
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
            inputState.add(SuccessState(StateRendererType.popupSuccessState, AppStrings.edit));
            userInput.add(data) ;
            UserProfile.viewModel.getProfile();
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
   Stream<UserModel?> get userOutput => userStreamController.stream.map((event) => event);

  @override
  setBio(bio) {
     user = user.copyWith(bio:bio) ;
  }

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
  void dispose() {
    userStreamController.close();
    imgStreamController.close();
    super.dispose();
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
}

abstract class UpdateProfileViewModelOutput {
  Stream <UserModel?> get userOutput ;

}

abstract class UpdateProfileViewModelInput {

  updateProfile();
  setBio(bio);
  setUserName(username);
  setImg();
  setName(name);
  toggle(String machine);
  updatePrice(String price);
  Sink get userInput ;
}