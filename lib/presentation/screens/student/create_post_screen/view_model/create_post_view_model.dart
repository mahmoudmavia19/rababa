import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/create_post_usecase.dart';
import 'package:rababa/domain/usecase/upload_img_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostViewModel extends BaseViewModel with CreatePostViewModelInput , CreatePostViewModelOutput {

  final StreamController<PostModel> postStreamController = BehaviorSubject<PostModel>() ;
  final StreamController<File> stackerStreamController = BehaviorSubject<File>() ;

  PostObject postObject = PostObject('', AppConstant.userObject?.uid, '', '', '', [] , false,DateTime.now(),[]) ;
  CreatePostUseCase createPostUseCase ;
  UploadFileToFirebaseUseCase uploadFileToFirebaseUseCase;
  File? video ;
  File? stacker ;
  CreatePostViewModel(this.createPostUseCase  , this.uploadFileToFirebaseUseCase);

  @override
  void start() {
    inputState.add(ContentState()) ;
   }
  @override
  void dispose() {
    postStreamController.close();
    stackerStreamController.close();
     super.dispose();
  }
  @override
  createPost() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(video != null ) {
      (await uploadFileToFirebaseUseCase.execute(UploadFileToFirebaseUseCaseInput(stacker!,AppConstant.postsStacker,video!.path.split('/').last,)))
          .fold((l) => null,
              (r) async{
            postObject = postObject.copyWith(postImg: r) ;
                (await uploadFileToFirebaseUseCase.execute(UploadFileToFirebaseUseCaseInput(video!,AppConstant.posts,video!.path.split('/').last,)))
                    .fold((failure) {
                inputState
                    .add(ErrorState(StateRendererType.popupErrorState, failure.message));
                }, (data) async{
                postObject = postObject.copyWith(postVideo: data);
                (await createPostUseCase.execute(PostModel(
                postObject.id,
                postObject.author,
                postObject.title,
                postObject.postImg,
                postObject. postVideo,
                postObject.likes,
                postObject.isLiked,
                postObject.date,
                postObject.comments,
               video!.path.split('/').last
                )))
                    .fold((failure) {
                inputState
                    .add(ErrorState(StateRendererType.popupErrorState, failure.message));
                }, (data) async{
                  inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));
                postInput.add(data) ;
                });
                });
              });

    }
    else {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, 'يجب ارفاق فديو'));
    }
  }


  @override
   Sink<PostModel> get postInput => postStreamController.sink;

  @override
   Stream<PostModel> get postOutput => postStreamController.stream.map((event) => event);

  @override
  setDescription(value) {
    postObject =  postObject.copyWith(title: value);
  }

  @override
   setVideo() async{
    XFile? videoFile  = await ImagePicker().pickVideo(source: ImageSource.gallery) ;
    video = File(videoFile!.path);
    setFirstVideoFrame();
  }

  @override
  validate(PostObject postObject) {
    return postObject.postVideo!.isNotEmpty
        && postObject.title!.isNotEmpty ;
  }

  @override
  setFirstVideoFrame() async{
    String imagePath = "${Directory.systemTemp.path}/${video!.path.split('/').last}";
     var thumbnailPath  = await VideoThumbnail.thumbnailData(
         video: video!.path ,
        quality: 30 ,
     ) ;
     print('-----------------$thumbnailPath----------------');
    stacker = await File(imagePath).writeAsBytes(thumbnailPath!);
    stackerInput.add(stacker!);

   }

  @override
   Sink<File> get stackerInput => stackerStreamController.sink;

  @override
   Stream<File> get stackerOutput => stackerStreamController.stream.map((event) => event);

  @override
  sharePost() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    (await createPostUseCase.execute(PostModel(
    postObject.id,
    postObject.author,
    postObject.title,
    postObject.postImg,
    postObject. postVideo,
    postObject.likes,
    postObject.isLiked,
    postObject.date,
    postObject.comments,
    postObject.postVideo,)))
        .fold((failure) {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) async{
    inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));
    postInput.add(data) ;
    });
  }
  }

abstract class CreatePostViewModelOutput {
   Stream<PostModel> get postOutput  ;
   Stream<File> get stackerOutput  ;
}

abstract class CreatePostViewModelInput {
  createPost() ;
  sharePost();
  validate(PostObject postObject);
  setDescription(value) ;
  setVideo() ;
  setFirstVideoFrame();
  Sink<PostModel> get postInput ;
  Sink<File> get stackerInput ;
}