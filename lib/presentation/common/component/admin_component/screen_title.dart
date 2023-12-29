import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style/admin_style.dart';

class ScreenTitle extends StatelessWidget {
    ScreenTitle({Key? key , required this.title} ) : super(key: key);
  String title ;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 218,
      height: 51,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.adminBoxColor
      ),
      child: Center(child: Text(title, style:AdminStyle.body36,)) ,
    );
  }
}
