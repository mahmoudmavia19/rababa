import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';

class OnBoardingTopScreen extends StatelessWidget {
    OnBoardingTopScreen({Key? key, required this.index}) : super(key: key);
   int index ;
  @override
  Widget build(BuildContext context) {
    return    Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppIcons.backs[0]),
        Image.asset(AppIcons.fronts[index],width: MediaQuery.of(context).size.width*0.7,),
      ],
    );
  }
}
