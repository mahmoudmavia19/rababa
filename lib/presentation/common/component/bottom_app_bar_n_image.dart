

import 'package:flutter/material.dart';
import 'package:rababa/presentation/resources/color_manager.dart';


class BottomAppNavigationImage extends StatelessWidget {

  BottomAppNavigationImage({Key? key, required this.imgPath , this.isSelected = false}) : super(key: key);
  String imgPath ;
  bool isSelected ;
  @override
  Widget build(BuildContext context) {
    return Image.asset(imgPath,height: 35,width: 35,color:isSelected? AppColor.bottomAppNavigationItemColor: null,);
  }
}
