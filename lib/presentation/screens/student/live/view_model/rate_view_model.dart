import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/rating_teacher_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/model/rate_model.dart';
import '../../../../../domain/usecase/get_all_users_usecase.dart';
import '../../../../../domain/usecase/get_list_of_users_usecase.dart';

class RateViewModel extends BaseViewModel with  RateViewModelInput {

  StreamController<double> ratingController = BehaviorSubject<double>();
  StreamController<UserModel?> teacherCon = BehaviorSubject<UserModel?>();

  RatingTeacherUseCase ratingTeacherUseCase ;
  GetListOfUsersUseCase getListOfUsersUseCase ;

  RateViewModel(this.ratingTeacherUseCase,this.getListOfUsersUseCase);

  RaterObject? rate = RaterObject(null, null, null, null, null);

  @override
  void start() {
    teacherCon.sink.add(null) ;
  }

  @override
  ratingTeacher() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    rate = rate!.copyWith(studentId: AppConstant.userObject!.uid! );
    rate = rate!.copyWith(date:DateTime.now());
    if(rate?.comment=='' && rate?.comment==null && rate?.rate == 0.0 && rate?.rate ==null)
      {
        inputState.add(ErrorState(StateRendererType.fullScreenErrorState, AppStrings.cantEmpty)) ;
        print('error1 ') ;
      }else {
      if(rate != null) {
        (await ratingTeacherUseCase.execute(RateModel(rate!.studentId!, rate!.teacherId!,
            rate!.rate!,rate!.comment!,rate!.date!))).fold((l) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, l.message)) ;
    }, (r)
    {
      inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, '')) ;
    });
      }else {
        inputState.add(ErrorState(StateRendererType.popupErrorState, AppStrings.cantEmpty)) ;
        print('error2 ') ;
      }
    }
  }

  @override
  setRate(double rate) {
   this.rate = this.rate!.copyWith(rate: rate);
   print(this.rate?.rate ) ;
  }

  @override
  setTeacherId(String id) {
     rate = rate?.copyWith(teacherId: id);
    print(rate?.teacherId ) ;
  }

  @override
  setComment(String value) {
    rate = rate!.copyWith(comment: value);
    print(rate?.comment);
  }

  @override
  getTeacher(String teacher) async{
   (await getListOfUsersUseCase.execute([teacher])).fold((l) {

   }, (r)
   {
     teacherCon.sink.add(r.last) ;
     if(r.last.isBlocked!){
       inputState.add(ErrorState(StateRendererType.fullScreenErrorState,'المعلم محظور')) ;
     }
   });
  }
  
}


abstract class RateViewModelInput {
  ratingTeacher();
  setRate(double rate) ;
  setTeacherId(String id);
  setComment(String value);
  getTeacher(String teacher);
}