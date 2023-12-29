import 'dart:async';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/get_comments_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';
class ShowCommentsViewModel extends BaseViewModel with ShowCommentsViewModelInput , ShowCommentsViewModelOutput {

  final StreamController<List<Map<String,dynamic>>> _commentsStream = BehaviorSubject<List<Map<String,dynamic>>>();
  // PostObject postObject  = PostObject('', '', '', '', '', [], false, DateTime.now(), []);
  PostModel postModel ;
  GetCommentsUseCase getCommentsUseCase;



  ShowCommentsViewModel(this.postModel, this.getCommentsUseCase);

  @override
  void start() {
    getAllComments();
   }

  @override
   Stream<List<Map<String,dynamic>>> get commentOutput => _commentsStream.stream.map((event) => event);

  @override
   Sink get commentsInput => _commentsStream.sink;

  @override
  getAllComments() async{
     inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
     (await getCommentsUseCase.execute(postModel)).fold((l) {
       inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message));
     }, (r) {
       commentsInput.add(r);
       if(r!.isEmpty){
         inputState.add(EmptyState('لا يوجد تعليقات')) ;
       }
       else{
         inputState.add(ContentState()) ; 
       }
     });
  }



}



abstract class ShowCommentsViewModelOutput {
  Stream<List<Map<String,dynamic>>> get commentOutput ;
}

abstract class ShowCommentsViewModelInput {
  Sink get commentsInput;
  getAllComments();


}