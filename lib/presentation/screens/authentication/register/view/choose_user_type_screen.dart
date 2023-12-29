import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/authentication/register/view/what_learn_type_screen.dart';
import 'package:rababa/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:rababa/presentation/screens/teacher/teacher_certificate/view_model/teacher_certificate_view_model.dart';
import 'dart:math' as math;

import '../../../../common/component/customButton.dart';
import '../../../../common/component/email_form_faild.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/strings_manager.dart';
class ChooseUsertypeScreen extends StatefulWidget {
  const ChooseUsertypeScreen({Key? key}) : super(key: key);

  @override
  State<ChooseUsertypeScreen> createState() => _ChooseUsertypeScreenState();
}

class _ChooseUsertypeScreenState extends State<ChooseUsertypeScreen> {

  final PageController _pageController = PageController(initialPage: 0);
  final TeacherCertificateViewModel _teacherViewModel = instance();
  double pv = 0.5 ;
  int screens = 1 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
          actions:pv==1 ||pv==0.75 ?  [
            IconButton(onPressed: (){
              if(pv==1) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WhatLearnTypeScreen(),));
              }
              else if(pv==0.75){
                _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);

              }
            }, icon: const Icon(Icons.arrow_forward_ios)),
          ] : null,
          leading: IconButton(onPressed: (){
            if(pv==1 || pv==0.75)
              {
                _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
              }
            else
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen(),));
              }
          }, icon: const Icon(Icons.arrow_back_ios)),

      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:Padding(
          padding: const EdgeInsets.all(20.0,),
          child: Column(
            children: [
              Container(height: 6.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5) ,
                  border: Border.all(color: Colors.grey)
                ),
                  child: LinearProgressIndicator(value: pv,minHeight: 6.0,backgroundColor: Colors.transparent,)),
              Expanded(
                child: PageView(
                  physics:const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      if(value==0){
                        pv = 0.5 ;
                      }
                      else if(value==1)
                        {
                          if(AppConstant.userType==UserType.teach)
                            {
                              pv = 0.75 ;
                            }
                          else {
                            pv = 1.0 ;
                          }
                        }
                      else {
                        pv = 1.0 ;
                      }
                    });
                  },
                  controller: _pageController,
                  children: [
                    _screen1() ,
                    if(AppConstant.userType==UserType.teach)
                      _screen2Teacher() ,
                    _screen2()
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  _screen1()=>Padding(
    padding: const EdgeInsets.all(50.0),
    child: Column(
      children: [
        Text(' مرحباً , ما الذي أتى بك إلى ربابة ', style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(height: 10.0,),
        Text('حدد هدفك الرئيسي', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),),
        const SizedBox(height: 20.0,),
        _screen1Item('التعلم', () {
          AppConstant.userType = UserType.learn;
          AppConstant.userObject = AppConstant.userObject!.copyWith(userType:AppConstant.userType.userString()) ;
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
        }),
        const SizedBox(height: 10.0,),
        _screen1Item('التدريس', () {
          AppConstant.userType = UserType.teach;
          AppConstant.userObject = AppConstant.userObject!.copyWith(userType:AppConstant.userType.userString()) ;
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
        }),
        const SizedBox(height: 10.0,),
        _screen1Item('الإستمتاع', () {
          AppConstant.userType = UserType.listen;
          AppConstant.userObject = AppConstant.userObject!.copyWith(userType:AppConstant.userType.userString()) ;
          _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);

        }),
      ],
    ),
  );

 Widget _screen1Item(title,GestureTapCallback action)=> InkWell(
   onTap:action,
   child: Container(
     padding: const EdgeInsets.all(5.0),
     decoration: BoxDecoration(
       border: Border.all(color: Colors.grey , width: 1.0) ,
       borderRadius: BorderRadius.circular(10.0)
     ),
     child:
     Row(
       children: [
         CircleAvatar(radius: 10.0,backgroundColor: Colors.grey[400],) ,
         const SizedBox(width: 10.0,),
         Text(title ,style: Theme.of(context).textTheme.bodyLarge,)
       ],
     ),
   ),
 );
  _screen2()=>Column(
    children: [
      const SizedBox(height: 70.0,) ,
      Image.asset(AppIcons.people) ,
      Text('أهلاً بك لقد اصبحت الآن من اصدقاء ربابة ', style: Theme.of(context).textTheme.titleLarge,),
      const SizedBox(height: 10.0,),
      Text('نتمنى لك رحلة موسيقية ممتعة ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),),
      const SizedBox(height: 90.0,),
      Transform.rotate(
        angle:math.pi,
        child: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WhatLearnTypeScreen(),));
        }, icon: const Icon(Icons.not_started_outlined , size: 50.0,color: AppColor.primary,)),
      )
    ],
  );

  _screen2Teacher()=>  SingleChildScrollView(
    child:StreamBuilder<FlowState>(
      stream: _teacherViewModel.outputState,
      builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _screen2TeacherStream(), (){
        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.linear);
      })??_screen2TeacherStream(),)
  );
  _screen2TeacherStream()=>  Column(
    children: [
      Image.asset(AppIcons.registerTopImage , width: double.infinity , fit: BoxFit.cover,),
      Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            StreamBuilder<XFile?>(
                stream: _teacherViewModel.imgStreamController.stream,
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      _teacherViewModel.setImg();
                    },
                    child: CustomTextField(title: AppStrings.certificate2 ,
                      enabled: false,subTitle:snapshot.data==null?  AppStrings.certificateLoad : snapshot.data!.name,
                      suffixIcon: const Icon(Icons.add_box_outlined),),
                  );
                }
            ),
            const SizedBox(height: 20.0,),
            CustomTextField(title: AppStrings.writeCertificate ,
              controller: TextEditingController(text:_teacherViewModel.certificateName),
              subTitle:AppStrings.writeCertificate ,
              onChanged: (value) {
                print(value) ;
                _teacherViewModel.setCertificate(value);
              },),
            const SizedBox(height: 30.0,) ,
            CustomButton(title: AppStrings.loadCertificate, onTap: () {
              _teacherViewModel.updateProfile();
            },),
          ],
        ),
      )
    ],
  );
}


