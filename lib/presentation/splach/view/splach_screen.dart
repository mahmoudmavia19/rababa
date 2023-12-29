import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/register/view/choose_user_type_screen.dart';
import 'package:rababa/presentation/screens/authentication/register/view/what_learn_type_screen.dart';
import 'package:rababa/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:rababa/presentation/splach/view_model/splach_view_model.dart';

import '../../../domain/usecase/check_login_usecase.dart';
import '../../screens/admin/main/view/admin_main_screen.dart';
import '../../screens/student/main_screen/view/student_main_screen.dart';
import '../../screens/teacher/teacher_main_screen/view/teacher_main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start() ;
    Timer(const Duration(seconds: 2), () async{
      _viewModel.checkLoginStream.stream.listen((event) {
        if(event!){
          print(AppConstant.userObject!.name.toString());
if(!AppConstant.userObject!.isBlocked!) {
  if(AppConstant.userObject!.email=='admin@gmail.com')
            {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AdminMainScreen(),), (route) => false);
            }
          else
            {
              if(AppConstant.userObject!.userType==null)
                {
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ChooseUsertypeScreen(),), (route) => false);
                }
              else if(AppConstant.userObject!.musicInstrument==null){
                Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   WhatLearnTypeScreen(),), (route) => false);
              }
              else if(AppConstant.userObject!.userType == UserType.teach.userString())
              {

                Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const TeacherMainScreen(),), (route) => false);
              }else {

                Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => StudentMainScreen(),), (route) => false);
              }

            }
}
else {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>OnBoardingScreen() ,));

}

        }else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>OnBoardingScreen() ,));
        }
      }) ;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppIcons.splachIcon) ,
          const SizedBox(height: 20.0,),
          const Text(AppStrings.rababa, style: TextStyle(fontSize: 100, color: Colors.black),),
          const SizedBox(height: 20.0,),
          const Text('""" الموسيقي للجميع"""', style: TextStyle(fontSize: 24, color: Colors.grey),),
          const SizedBox(height: 20.0,),
          const Text('Music for All', style: TextStyle(fontSize: 24, color: Colors.grey),),
        ],
      ),
    );
  }
}
