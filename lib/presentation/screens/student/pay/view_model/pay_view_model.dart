import 'dart:async';
import 'dart:math';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/model/order_model.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../../domain/usecase/pay_usecase.dart';

class PayViewModel extends BaseViewModel with PayViewModelInput , PayViewModelOutput {

  StreamController<DateTime> datePicker = BehaviorSubject<DateTime>() ;
  OrderObject orderObject =OrderObject(null, null, null, null, null, null, null, null, null);
  PayUseCase payUseCase ;
  String cvv  = '';
  PayViewModel(this.payUseCase);

  @override
  void start() {
   inputState.add(ContentState()) ;
     }

  @override
  setDate(DateTime date) {
   orderObject =  orderObject.copyWith(date: date) ;
   datePicker.sink.add(date) ;
  }

  @override
  setTeacher(UserModel teacher) {
    orderObject =  orderObject.copyWith(teacherName:teacher.name) ;
    orderObject =  orderObject.copyWith(teacherId:teacher.uid) ;
    orderObject =  orderObject.copyWith(machine:teacher.musicInstrument) ;
  }

  @override
  setTotal(String? total) {
    orderObject =  orderObject.copyWith(total: total) ;
  }

  @override
  pay() async{
/*
    setTotal('100SR');
*/
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    if(cvv.length==3) {
      (await payUseCase.execute(OrderModel(
      date: orderObject.date ,
      teacherName: orderObject.teacherName ,
      orderNumber: Random().nextInt(1000).toString() ,
      studentName: AppConstant.userObject!.name,
      total: orderObject.total ,
      studentId:  AppConstant.userObject!.uid,
      machine: orderObject.machine ,
      teacherId:   orderObject.teacherId ,
    ))).fold((l){
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState , l.message)) ;

    }, (r)
    {
      inputState.add(SuccessState(StateRendererType.fullScreenSuccessState,'')) ;

    }
    ) ;
    }
    else {
      inputState.add(ContentState()) ;

    }
  }

  @override
  setMachine(String machine) {
  orderObject = orderObject.copyWith(machine: machine) ;
  }


}

abstract class PayViewModelOutput {
}

abstract class PayViewModelInput {
  setDate(DateTime date) ;
  setTotal(String? total) ;
  setTeacher(UserModel teacher) ;
  setMachine(String machine) ;
  pay();
}