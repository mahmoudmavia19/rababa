import 'package:flutter/material.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/login/view/login_screen.dart';
import 'package:rababa/presentation/screens/authentication/register/view/registration.dart';
import 'package:rababa/presentation/screens/onboarding/onboarding_top_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_bottom_screen.dart';

class OnBoardingScreen extends StatefulWidget {
    OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();

  @override
  void initState() {
    _pageController.addListener(() {
      print('s');
      _pageController2.animateTo(_pageController.offset, duration: const Duration(milliseconds: 1),curve: Curves.linear);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100.0,
        title: Row(
          children: [
            Text(AppStrings.rababa, style: Theme.of(context).textTheme.titleLarge,),
            Image.asset(AppIcons.logo)
          ],
        ),
      ),
      body:SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // component 1
            SizedBox(
              height: MediaQuery.of(context).size.height*0.4,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: PageView.builder(
                   onPageChanged:(value) {
                   },
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount:  AppIcons.fronts.length,
                  itemBuilder: (context, index) => OnBoardingTopScreen(index: index),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            // component 2
            SmoothPageIndicator(
              textDirection: TextDirection.ltr,
                controller: _pageController, // PageController
                count:AppIcons.fronts.length,
                effect:  const WormEffect(
                  activeDotColor: AppColor.primary,
                  dotColor:  AppColor.primary,paintStyle: PaintingStyle.stroke , strokeWidth: 1.0 ),  // your preferred effect
                onDotClicked: (index){

                }
            ),
            const SizedBox(height: 20.0,),
            // component 3
            SizedBox(
              height: MediaQuery.of(context).size.height*0.14,
              child: Directionality(
                 textDirection: TextDirection.ltr,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController2,
                  itemBuilder: (context, index) =>  OnBoardingBottomScreen(index:index),
                  itemCount: AppIcons.fronts.length,
                ),
              ),
            ),
            // component 4
            const SizedBox(height: 20.0,),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              CustomButton(title: AppStrings.register2, onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationScreen(),));
              }),
              const SizedBox(height: 20.0,),
              CustomButton(
                key: const Key('login_btn'),
                title: AppStrings.login, onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));

              }, color:AppColor.scaffoldBackgroundColor,textColor: Colors.black,),
            ],
          ),
        ),

          ],
        ),
      )
    );
  }
}
