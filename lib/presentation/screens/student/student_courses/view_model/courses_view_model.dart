import 'dart:async';

import 'package:intl/intl.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../data/model/order_model.dart';
import '../../../../../domain/usecase/get_all_orders.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class StudentCoursesViewModel extends BaseViewModel with GetAllOrdersUseCaseInput , GetAllOrdersUseCaseOutput {
  StreamController<List<OrderModel>> current = BehaviorSubject<List<OrderModel>>() ;
  StreamController<List<OrderModel>> last = BehaviorSubject<List<OrderModel>>() ;
  StreamController<List<OrderModel>> future = BehaviorSubject<List<OrderModel>>() ;
  GetAllOrdersUseCase getAllOrdersUseCase ;

  StudentCoursesViewModel(this.getAllOrdersUseCase);

  @override
  void start() {
    getAllOrders() ;
  }

  @override
  getAllOrders() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState)) ;
    (await getAllOrdersUseCase.execute(AppConstant.nullVoid())).fold((l) {
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState , l.message)) ;
    }, (r) {
      List<OrderModel> currentList = [] ;
      List<OrderModel> lastList = [];
      List<OrderModel> futureList = [] ;
      for(var order in r){
        print(order.orderNumber) ;
        if(_currentDate(order.date!)){
          order.status = 'بداء ${timeago.format(order.date!,locale:'ar',allowFromNow:true)}';

          currentList.add(order);
        }
        else if ((order.date?.microsecondsSinceEpoch??0) > DateTime.now().microsecondsSinceEpoch) {
          order.status = 'قادمة ${timeago.format(order.date!,locale:'ar',allowFromNow:true)}';
           futureList.add(order);
        }
        else {
          order.status = ' تم الإنتهاء منها ${timeago.format(order.date!,locale:'ar',allowFromNow:true)}';

          lastList.add(order) ;
        }
      }
      current.add(currentList);
      last.add(lastList);
      future.add(futureList);
      inputState.add(ContentState());
    });
  }

  @override
  bool _currentDate(DateTime date) {
    var dateNow = DateTime.now(); 
     return dateNow.year == date.year && dateNow.month == date.month && dateNow.day == date.day; 
  }

}

abstract class GetAllOrdersUseCaseOutput {

}

abstract class GetAllOrdersUseCaseInput {
  getAllOrders();
 bool _currentDate(DateTime  date); 
}