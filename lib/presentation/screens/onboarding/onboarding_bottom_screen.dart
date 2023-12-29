import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

class OnBoardingBottomScreen extends StatelessWidget {
    OnBoardingBottomScreen({Key? key, required this.index}) : super(key: key);
    int index  ;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(AppStrings.onBoardingTitle[index], style: Theme.of(context).textTheme.titleLarge,),
          Text(AppStrings.onBoardingSubTitle[index],style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
