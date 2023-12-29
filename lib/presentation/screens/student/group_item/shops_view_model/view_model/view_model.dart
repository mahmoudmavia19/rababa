import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/domain/usecase/admin_usecases/get_all_shops_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/model/shop_model.dart';

class StudentShopsViewModel extends BaseViewModel {
  GetAllShopsUseCase getAllShopsUseCase;
  final StreamController<List<ShopModel>> controller = BehaviorSubject<List<ShopModel>>();
  StudentShopsViewModel(this.getAllShopsUseCase);

  @override
  void start() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllShopsUseCase.execute(AppConstant.nullVoid())).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      controller.sink.add(data!);
      inputState.add(ContentState());
    });
  }
}
