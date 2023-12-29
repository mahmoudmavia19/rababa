import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class MainViewModel extends BaseViewModel {

  final StreamController<int> navigatorStreamController = BehaviorSubject<int>();
  final PageController mainPageCon = PageController() ;
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