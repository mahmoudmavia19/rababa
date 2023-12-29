import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class CustomButton extends StatelessWidget {
     CustomButton({Key? key , required this.title ,required this.onTap, this.height,this.color , this.textColor}) : super(key: key);
    String title ;
    double? height ;
    Color? color ;
    Color? textColor ;
    VoidCallback onTap ;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: MaterialButton(
         onPressed: onTap,
        color:color?? AppColor.primary[600],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),side: const BorderSide(color:AppColor.primary)),
        child:   Text(title,style: TextStyle(
            color: textColor??Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 38.0), ),),
    );
  }
}
