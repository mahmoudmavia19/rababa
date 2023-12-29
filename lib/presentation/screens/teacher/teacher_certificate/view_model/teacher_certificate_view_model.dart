import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../domain/usecase/add_certificate_usecase.dart';
import '../../../../../domain/usecase/upload_img_usecase.dart';
import '../../../../resources/strings_manager.dart';

class TeacherCertificateViewModel extends BaseViewModel with TeacherCertificateViewModelInput {
  final StreamController<XFile?>   imgStreamController = BehaviorSubject<XFile?>();
  UploadFileToFirebaseUseCase uploadImgUseCase ;
  AddCertificateUseCase addCertificateUseCase ;
  String? certificateName = AppConstant.userObject!.certificate;
  File? img ;
  String? fileName;
  TeacherCertificateViewModel(this.uploadImgUseCase , this.addCertificateUseCase);

  @override
  void start() {
    // TODO: implement start
  }


  @override
  setImg() async{
    final image = await  ImagePicker().pickImage(source: ImageSource.gallery);
    imgStreamController.add(image);
    img =  File(image!.path) ;
    fileName = image.name;

  }


  @override
  updateProfile() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await uploadImgUseCase.execute(UploadFileToFirebaseUseCaseInput(img!,AppConstant.certificates,fileName!,)))
          .fold((failure) {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState, failure.message));
      }, (data) async{

            print(data) ;
            List<String> list = [] ;
            for(var i in AppConstant.userObject!.certificates??[]){
              list.add(i) ;
            }

            list.add(data!);
            AppConstant.userObject = AppConstant.userObject!.copyWith(certificates: list);
            print(AppConstant.userObject?.certificates) ;

        (await addCertificateUseCase.execute(AddCertificateUseCaseInput(data, certificateName)))
            .fold((failure) {
          inputState
              .add(ErrorState(StateRendererType.fullScreenErrorState, failure.message));
        }, (data) async{
          inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.edit));
          });
      });

  }


  @override
  setCertificate(String value) {
    certificateName = value;
  }


}

abstract class TeacherCertificateViewModelInput {
  setImg();
  updateProfile();
  setCertificate(String value);
}