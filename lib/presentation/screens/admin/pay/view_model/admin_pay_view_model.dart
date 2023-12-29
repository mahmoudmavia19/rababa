import 'dart:async';

 import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/get_all_pay_operations_usecase.dart';

class AdminPayOperationsViewModel extends BaseViewModel with AdminPayOperationsInput {

  StreamController<List<OrderModel>> ordersStreamCon = BehaviorSubject<List<OrderModel>>();
  GetAllPayOperationsUseCase getAllPayOperationsUseCase;

  AdminPayOperationsViewModel(this.getAllPayOperationsUseCase);

  @override
  void start() {
    getAllPayOperations() ;
  }

  @override
  getAllPayOperations() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllPayOperationsUseCase.execute(AppConstant.nullVoid())).fold((l){
      inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message));
    }, (r) {
      ordersStreamCon.sink.add(r) ;
      inputState.add(ContentState());
    }
    ) ;
  }


}

abstract class AdminPayOperationsInput {
  getAllPayOperations();
}