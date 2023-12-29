import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/complaint_model.dart';
import 'package:rababa/domain/usecase/admin_usecases/get_all_complaint_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class AdminComplaintViewModel extends BaseViewModel with AdminComplaintViewModelInput , AdminComplaintViewModelOutput {

  final StreamController<List<ComplaintModel>> _complaintStreamCon = BehaviorSubject<List<ComplaintModel>>() ;
  GetAllComplaintUseCase getAllComplaintUseCase ;

  AdminComplaintViewModel(this.getAllComplaintUseCase);

  @override
  void start() {
    getAllComplaints();
  }

  @override
   Sink get complaintInput => _complaintStreamCon.sink ;

  @override
  getAllComplaints() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllComplaintUseCase.execute(AppConstant.nullVoid())).fold((l){
    inputState.add(ErrorState(StateRendererType.fullScreenErrorState, l.message,));
    }, (data){
    complaintInput.add(data);
    inputState.add(ContentState());

    });

  }

  @override
   Stream<List<ComplaintModel>> get complaintOutput => _complaintStreamCon.stream.map((event) => event);

}

abstract class AdminComplaintViewModelOutput {
  Stream get complaintOutput ;

}

abstract class AdminComplaintViewModelInput {
  Sink get complaintInput ;
  getAllComplaints() ;
}