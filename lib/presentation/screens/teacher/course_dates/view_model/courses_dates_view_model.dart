import 'dart:async';

import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/model/order_model.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../../domain/usecase/get_list_of_users_usecase.dart';
import '../../../../../domain/usecase/get_teacher_orders_usecase.dart';

class CoursesDatesViewModel extends BaseViewModel with CoursesDatesViewModelInput , CoursesDatesViewModelOutput {
  final StreamController<List<OrderModel>> _controller = BehaviorSubject<List<OrderModel>>();
  GetTeacherOrdersUseCase getTeacherOrdersUseCase;
  GetListOfUsersUseCase getListOfUsersUseCase ;
  CoursesDatesViewModel(this.getTeacherOrdersUseCase,this.getListOfUsersUseCase);
  List<UserModel> userOfOrders = [] ;
  @override
  void start() {
    // TODO: implement start
  }

  @override
   Sink<List<OrderModel>> get orderInput => _controller.sink;

  @override
   Stream<List<OrderModel>> get ordersOutput => _controller.stream.map((event) => event);

  @override
  getOrdersDay(DateTime date) async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    (await getTeacherOrdersUseCase.execute(date)).fold((l) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message)) ;
    }, (r) async{
      if(r.isEmpty){
        inputState.add(EmptyState('')) ;
      }else {
        print(' day now ${DateTime.now(). microsecondsSinceEpoch} ---${DateTime.now()}  ') ;
        print(' day last ${date.microsecondsSinceEpoch} --- ${date} --- ${r[1].date!.microsecondsSinceEpoch} ') ;
        List<OrderModel> list= [] ;
        for(var item in r){
          var start =date ;
          var end = date.add(const Duration(days: 1));
          if(start.microsecondsSinceEpoch<=item.date!.microsecondsSinceEpoch && end.microsecondsSinceEpoch>item.date!.microsecondsSinceEpoch ){
            list.add(item) ;
          }
        }
        if(list.isEmpty){
          inputState.add(EmptyState('')) ;
        }else {
          print(list.length);
          orderInput.add(list);
          inputState.add(ContentState());
        }
        List<String> listString = [] ;
        for(var orderItem in list){
          listString.add(orderItem.studentId!);
        }
        (await getListOfUsersUseCase.execute(listString)).fold((l) {

        }, (r) {
          userOfOrders = r ;
        });
      }
    });
    }

}


abstract class CoursesDatesViewModelOutput {
  Stream<List<OrderModel>> get ordersOutput ;
}

abstract class CoursesDatesViewModelInput {
  Sink<List<OrderModel>> get orderInput ;
  getOrdersDay(DateTime date);
}