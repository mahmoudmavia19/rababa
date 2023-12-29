import 'package:flutter/material.dart';
import 'package:rababa/presentation/common/component/bottom_app_bar_n_image.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/teacher/teahcer_profile/view/teacher_profile.dart';

import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../student/create_post_screen/view/create_post_screen.dart';
import '../../../student/group_item/groups_view_model/view/group_screen.dart';
import '../../course_dates/view/course_dates_screen.dart';
import '../view_model/Teacher_main_view_model.dart';


class TeacherMainScreen extends StatefulWidget {
  const TeacherMainScreen({Key? key}) : super(key: key);

  @override
  State<TeacherMainScreen> createState() => _TeacherMainScreenState();
}

class _TeacherMainScreenState extends State<TeacherMainScreen> {


  final TeacherMainViewModel _viewModel =  instance();
  int _curIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        onPageChanged: (value) {
          _curIndex = value;
           _viewModel.changePageState(value) ;
          FocusScope.of(context).unfocus();
        },
        controller:AppConstant.pageController ,
        children: const [
          TeacherProfile(),
          CreatePostScreen(),
          CourseDatesScreen(),
          GroupScreen(),

        ],
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: _viewModel.navigatorStreamController.stream,
        builder: (context, snapshot) {
          return BottomNavigationBar(items:[
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.person,isSelected: _isSelected(0)), label: 'profile',backgroundColor: AppColor.scaffoldBackgroundColor,),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.add,isSelected: _isSelected(1)), label: 'add'),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.time,isSelected: _isSelected(2)), label: 'time'),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.group,isSelected: _isSelected(3)), label: 'group',),
          ], iconSize: 32.94 , currentIndex: 0,elevation: 50.0,
            onTap: (value) {
              AppConstant.pageController.jumpToPage(value);
              _curIndex = value ;
             _viewModel.changePageState(value);

            },

          );
        }
      ),
    );


  }

  bool _isSelected(index){
    return _curIndex == index;
  }
}
