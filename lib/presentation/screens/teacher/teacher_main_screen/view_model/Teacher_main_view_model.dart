import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../../base/base_viewmodel.dart';

class TeacherMainViewModel extends BaseViewModel {

  final StreamController<int> navigatorStreamController = BehaviorSubject<int>();
  changePageState(int index){
    navigatorStreamController.add(index);
  }

  @override
  void dispose() {
    navigatorStreamController.close();
    super.dispose();
  }

  @override
  void start() {

  }
}