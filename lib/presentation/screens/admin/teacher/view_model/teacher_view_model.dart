import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/getAllTeacher.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/admin_usecases/add_action_to_teacher_usecase.dart';

class TeacherViewModel extends BaseViewModel with  TeacherViewModelInput , TeacherViewModelOutput{

  StreamController<List<UserModel>?> teachersStream = BehaviorSubject<List<UserModel>?>() ;
  GetAllTeacherUseCase getAllTeacherUseCase ;
  AddActionToTeacherUseCase addActionToTeacherUseCase ;
  List<UserModel>? teachers = [] ;

  TeacherViewModel(this.getAllTeacherUseCase, this.addActionToTeacherUseCase);

  @override
  void start() {
    getAllTeacher() ;
   }

  @override
  getAllTeacher()async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllTeacherUseCase.execute(AppConstant.nullVoid())).fold(
            (l) {
              inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message)) ;
            } ,
     (r)
    {
      teacherInput.add(r);
      teachers = r;
      inputState.add(ContentState());
    }
    );
  }

  @override
   Sink get teacherInput => teachersStream.sink;

  @override
   Stream<List<UserModel>?> get teacherOutput => teachersStream.stream.map((event) => event);



  @override
   blockTeacher(int index) async{

    teachers![index].isBlocked = teachers![index].isBlocked==null ? true : !teachers![index].isBlocked!;
    (await addActionToTeacherUseCase.execute(teachers![index])).fold((l) {

    }, (r) {
      teacherInput.add(teachers);
    }) ;
  }

  @override
  acceptTeacher(int index) async{
    teachers![index].isAccepted = teachers![index].isAccepted==null ? true : !teachers![index].isAccepted!;
    (await addActionToTeacherUseCase.execute(teachers![index])).fold((l) {
    }, (r) {
    teacherInput.add(teachers);
    }) ;
  }


}

abstract class TeacherViewModelOutput {
  Stream<List<UserModel>?> get teacherOutput ;
}

abstract class TeacherViewModelInput {
  getAllTeacher();
   acceptTeacher(int index);
   blockTeacher(int index);
  Sink get teacherInput ;
}