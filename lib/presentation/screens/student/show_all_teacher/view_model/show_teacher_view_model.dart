import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/getAllTeacher.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/model/rate_model.dart';
import '../../../../../domain/usecase/get_rating_teacher_usecase.dart';
import '../../../../base/base_viewmodel.dart';

class ShowAllTeachersViewModel extends BaseViewModel  with ShowAllTeachersViewModelInput ,ShowAllTeachersViewModelOutput {

  final StreamController teacherStream = BehaviorSubject<List<UserModel>>();
  final StreamController compareErrorStream = BehaviorSubject<bool>();
  GetAllTeacherUseCase getAllTeacherUseCase ;
  GetRatingTeacherUseCase getRatingTeacherUseCase;

  String teacherType = AppConstant.qanun ;
  ShowAllTeachersViewModel(this.getAllTeacherUseCase,this.getRatingTeacherUseCase);

  @override
  void start() {
    getAllTeacher();
  }

  @override
  getAllTeacher() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    (await getAllTeacherUseCase.execute(AppConstant.nullVoid())).fold((failure) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState , failure.message)) ;
    }, (data)async {
      if(data==null && data ==[]) {
        inputState.add(EmptyState(AppStrings.emptyContent));
    }else {
var teachers = data!.where((element) => element.musicInstrument == teacherType)
    .toList();
List<UserModel> teachersWithRate = [] ;
for(var teacher in teachers) {
  (await getRatingTeacherUseCase.execute(teacher.uid!)).fold((l) {

  }, (r) {
     double rate = 0 ;

    if(r.isNotEmpty) {
      for (var item in r) {
        rate += item.rate;
      }
      rate = rate / r.length;
    }else {
      rate = 0.0 ;
    }
     teacher.rate = rate ;
     teachersWithRate.add(teacher);
   });
}
teacherInput.add(teachersWithRate);
inputState.add(ContentState());
      }
    });
  }


  @override
   Sink get teacherInput => teacherStream.sink;

  @override
   Stream<List<UserModel>> get teacherOutput => teacherStream.stream.map((event) => event);

  @override
  compareErrorHandle(List list) {
    if(list.length<2 || list.length>3)
      {
        inputState.add(ErrorState(StateRendererType.popupErrorState, 'من فضلك اختر 2-3 معلمين '));
        compareErrorStream.sink.add(false);
      } else {
      inputState.add(ContentState());
      compareErrorStream.sink.add(true);
    }
  }

}

abstract class ShowAllTeachersViewModelInput {

  Sink get teacherInput ;
  getAllTeacher();
  compareErrorHandle(List list) ;
 }
abstract class ShowAllTeachersViewModelOutput {
  Stream<List<UserModel>> get teacherOutput ;
}