import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/component/email_form_faild.dart';
import 'package:rababa/presentation/common/component/password_form_faild.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/register/view/choose_user_type_screen.dart';
import 'package:rababa/presentation/screens/authentication/login/view/login_screen.dart';
import 'package:rababa/presentation/screens/authentication/register/view_model/register_view_model.dart';
import 'package:rababa/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:rababa/presentation/screens/student/main_screen/view/student_main_screen.dart';

import '../../../../../app/end_points/constant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  RegisterViewModel viewModel = instance();

  _bind(){
    viewModel.start();
    viewModel.isUserRegisteredInSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn)
      {
        WidgetsBinding.instance.addPostFrameCallback((_) {

          Navigator.of(context)
              .pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>   const ChooseUsertypeScreen(),), (route) => false);
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
  void dispose()
  {
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
          }, icon: Icon(Icons.arrow_back_ios)),
            centerTitle: true,
            toolbarHeight: 70,
            elevation: 0.0,
            title:
            Column(
              children: [
                Image.asset(AppIcons.logo) ,
                Text(
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            )
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<FlowState>(
            stream: viewModel.outputState,
              builder: (context, snapshot) => snapshot.hasData ? snapshot.data?.getScreenWidget(context,
                  _scaffoldWidgets(),(){
                if(snapshot.data?.getStateRendererType() == StateRendererType.popupSuccessState)
                  {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseUsertypeScreen(),));
                  }
                  }) : _scaffoldWidgets(),
          ),
        ),
      ),
    );
  }

  _scaffoldWidgets ()=> StreamBuilder<RegisterObject>(
    stream: viewModel.outputStreamController,
    builder: (context, snapshot) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppIcons.registerTopImage , width: double.infinity , fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  CustomTextField(title: AppStrings.username , subTitle: '5 احرف او اقل', onChanged: (value) {
                    viewModel.setUserName(value);
                  },
                    formatters: [
                      AppConstant.engREX
                    ],
                  )  ,
                  CustomTextField(
                    formatters: [
                      AppConstant.engREX
                    ],
                    title: AppStrings.email , subTitle: 'you@example.com', onChanged: (value) {
                    viewModel.setEmail(value);
                  },)  ,
                  const SizedBox(height: 20.0,),
                  PasswordFormField(title: AppStrings.password,onChanged: (value) {
                    viewModel.setPassword(value);
                  }, ),
                  const SizedBox(height: 20.0,),
                  CustomButton(title: AppStrings.register, onTap: () {
                    viewModel.register();
                  },),
                  const SizedBox(height: 10.0,),
                  Row(
                    children: [
                    Text('إنشائك لحساب يعني انك توافق على' , style: Theme.of(context).textTheme.bodySmall,),
                    TextButton(
                      onPressed: () {

                      },
                        child: Text(' إتفاقية المستخدمة' , style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primary),)),
                    Text('و' , style: Theme.of(context).textTheme.bodySmall,),
                    TextButton(
                      onPressed: () {

                      },
                        child: Text('سياسة الخصوصية' , style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColor.primary),)),
                    Text('لدى ربابة' , style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  );
}
