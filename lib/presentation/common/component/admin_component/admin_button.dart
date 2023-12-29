import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/style/admin_style.dart';

class AdminButton extends StatelessWidget {
  AdminButton({Key? key , required this.title , required this.onTap} ) : super(key: key);
  String title ;
  VoidCallback onTap ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 218,
      height: 51,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.adminBoxColor
      ),
      child: MaterialButton(
        onPressed:onTap,
          child: Center(child: Text(title, style:AdminStyle.body36,))) ,
    );
  }
}
