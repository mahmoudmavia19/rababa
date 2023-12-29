import 'package:flutter/material.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/screens/student/main_screen/view/student_main_screen.dart';
import 'package:rababa/presentation/screens/teacher/teacher_main_screen/view/teacher_main_screen.dart';
import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../student/update_profile_screen/view_model/update_profile_view_model.dart';

class WhatLearnTypeScreen extends StatelessWidget {
    WhatLearnTypeScreen({Key? key}) : super(key: key);
  final UpdateProfileViewModel _viewModel = instance();

  @override
  Widget build(BuildContext context) {
    print(AppConstant.userType);
    return Scaffold(
      appBar: AppBar(elevation: 0.0,), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical:50.0 , horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(AppConstant.userType==UserType.teach? 'حدد الالة التي ستقوم بتعليمها':  'حدد الآلة التي تريد تعلمها', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: 10.0,),
              Text('يمكنك تغييرها في أي وقت لاحقاً', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),),
              const SizedBox(height: 100.0,),
              Row(
                children: [
                  _leanItem(context, AppIcons.learn3,'ناي'),
                  _leanItem(context, AppIcons.learn2,'كمان'),
                  _leanItem(context, AppIcons.learn1,'قانون'),
                  _leanItem(context, AppIcons.learn4,'عود'),
                ],
              )
            ],
          ),
        ),
      ),
    ); 
  }
  
  _leanItem(context, icon,title)=> Expanded(child: InkWell(
    onTap: (){
      if(AppConstant.userType == UserType.teach) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>const TeacherMainScreen()), (route) => false,);
      }
      else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StudentMainScreen()), (route) => false,);
      }
      _viewModel.user = _viewModel.user.copyWith(userType: AppConstant.userType.userString(), musicInstrument: title);
      _viewModel.updateProfile();
    },
    child: Column(
      children: [
        Image.asset(icon),
        const SizedBox(height: 0.5,) ,
        Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),)
      ],
    ),
  ));
}
