import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/bottom_app_bar_n_image.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/create_post_screen/view/create_post_screen.dart';
import 'package:rababa/presentation/screens/student/main_screen/view_model/main_view_model.dart';
import 'package:rababa/presentation/screens/student/show_all_teacher/view/show_all_teachers.dart';
import 'package:rababa/presentation/screens/student/student_courses/view/student_courses.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view/student_user_profile.dart';

import '../../group_item/groups_view_model/view/group_screen.dart';

class StudentMainScreen extends StatefulWidget {
    StudentMainScreen({Key? key}) : super(key: key);

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {

  MainViewModel viewModel = instance();
    int _curIndex = 0 ;
    @override
  void dispose() {
   viewModel.dispose() ;
    super.dispose();
  }
  @override
  void initState() {
     super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(

        onPageChanged: (value) {
          _curIndex = value;
          viewModel.changePageState(value);
          FocusScope.of(context).unfocus();

        },
        controller:AppConstant.pageController ,
        children:   const [
          UserProfile(),
          GroupScreen(),
          CreatePostScreen(),
          StudentCourses(),
          ShowAllTeachers(),
        ],
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: viewModel.navigatorStreamController.stream,
        builder: (context, snapshot) {
          return BottomNavigationBar(items:[
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.person,isSelected: _isSelected(0)), label: 'profile',backgroundColor: AppColor.scaffoldBackgroundColor,),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.group,isSelected: _isSelected(1)), label: 'group',),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.add,isSelected: _isSelected(2)), label: 'add'),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.time,isSelected: _isSelected(3)), label: 'time'),
            BottomNavigationBarItem(icon: BottomAppNavigationImage(imgPath:AppIcons.teacherIcon,isSelected: _isSelected(4),), label: 'teachers',),
          ], iconSize: 32.94 , currentIndex: 0,elevation: 50.0,
            onTap: (value) {
              AppConstant.pageController.jumpToPage(value);
              _curIndex = value ;
              viewModel.changePageState(value);

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
