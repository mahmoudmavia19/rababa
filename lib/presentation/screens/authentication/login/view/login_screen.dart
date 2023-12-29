import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/component/email_form_faild.dart';
import 'package:rababa/presentation/common/component/password_form_faild.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/forget_password_screen/view/forget_password_screen.dart';
import 'package:rababa/presentation/screens/authentication/login/view_model/login_view_model.dart';
 import 'package:rababa/presentation/screens/student/main_screen/view/student_main_screen.dart';

import '../../../admin/main/view/admin_main_screen.dart';
import '../../../onboarding/onboarding_screen.dart';
import '../../../teacher/teacher_main_screen/view/teacher_main_screen.dart';
import '../../register/view/choose_user_type_screen.dart';
import '../../register/view/what_learn_type_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel viewModel = instance();


  _bind(){
    viewModel.start();
    viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn)
      {
        SchedulerBinding.instance.addPostFrameCallback((_) {

          if(AppConstant.userObject!.email=='admin@gmail.com')
          {
            Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AdminMainScreen(),), (route) => false);
          }
          else {

            if(AppConstant.userObject!.userType==null)
            {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ChooseUsertypeScreen(),), (route) => false);
            }
            else if(AppConstant.userObject!.musicInstrument==null){
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   WhatLearnTypeScreen(),), (route) => false);
            }
            else if (AppConstant.userObject!.userType ==
                UserType.teach.userString()) {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) => const TeacherMainScreen(),), (
                  route) => false);
            } else {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) => StudentMainScreen(),), (route) => false);
            }
          }
        });
      }
    });
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  void dispose() {
    viewModel.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen(),));
            }, icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          toolbarHeight: 70,
          elevation: 0.0,
          title:
           Column(
             children: [
               Image.asset(AppIcons.logo,) ,
               Text(
                 AppStrings.welcomeBack,
                 style: Theme.of(context).textTheme.bodyLarge,
               ),
             ],
           )
        ),
        body:Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<FlowState>(
            stream:  viewModel.outputState,
              builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidgets(), (){})??_scaffoldWidgets(),
          ),
        ) ,
      ),
    );
  }

  _scaffoldWidgets()=>StreamBuilder<LoginObject>(
    stream: viewModel.outputStreamController,
    builder: (context, snapshot) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                formatters: [
                  AppConstant.engREX
                ],
                key: const Key('email'),
                title: AppStrings.email , subTitle: 'you@example.com' , onChanged: (value) {
                viewModel.setEmail(value);
              },) ,
              const SizedBox(height: 20.0,),
              PasswordFormField
                (
                key: const Key('password'),
                title: AppStrings.password , onChanged: (value) {
                viewModel.setPassword(value);
              },),
              const SizedBox(height: 20.0,),
              CustomButton(
                key: const Key('login'),
                title: AppStrings.login, onTap: () {
                viewModel.login();
              },),
              Align(
                alignment: Alignment.center,
                child: TextButton(onPressed: () {
                  initForgetPasswordModule() ;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen(),));
                }, child: Text(AppStrings.forgetPassword, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.primary),)),
              ),
            ],
          ),
        ),
      );
    }
  );
}
