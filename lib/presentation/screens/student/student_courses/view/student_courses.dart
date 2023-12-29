import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/screens/student/courses_items/current_courses.dart';
import 'package:rababa/presentation/screens/student/courses_items/previous_courses.dart';
import 'package:rababa/presentation/screens/student/courses_items/upcoming_courses.dart';

import '../../../../../data/model/order_model.dart';
import '../view_model/courses_view_model.dart';

class StudentCourses extends StatefulWidget {
  const StudentCourses({Key? key}) : super(key: key);

  @override
  State<StudentCourses> createState() => _StudentCoursesState();
}

class _StudentCoursesState extends State<StudentCourses> {

  final StudentCoursesViewModel _viewModel = instance();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('close') ;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 10.0,
          bottom:  TabBar(
            tabs:   [
              Tab(child: Text('الحالية' ,style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey), )),
              Tab(child: Text('الماضية' ,style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey), )) ,
              Tab(child: Text('القادمة' ,style:  Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey), )) ,
            ],isScrollable: false ,   ),
        ),
        body:  StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context,TabBarView(children: [
              StreamBuilder<List<OrderModel>>(
                  stream: _viewModel.current.stream,
                  builder: (context, snapshot) {
                    return CurrentCourses(items: snapshot.data??[],);
                  }
              ),
              StreamBuilder<List<OrderModel>>(
                  stream: _viewModel.last.stream,
                  builder: (context, snapshot) {
                    return PreviousCourses(items: snapshot.data??[],);
                  }
              ),
              StreamBuilder<List<OrderModel>>(
                  stream: _viewModel.future.stream,
                  builder: (context, snapshot) {
                    return UpcomingCourses(items: snapshot.data??[],);
                  }
              ),

            ]), (){})??Container();
          }
        ),
      ),
    );
  }
}
