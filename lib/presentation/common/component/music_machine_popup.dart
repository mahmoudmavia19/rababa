import 'package:flutter/material.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class MusicMachinePopup extends StatefulWidget {
  const MusicMachinePopup({Key? key}) : super(key: key);

  @override
  State<MusicMachinePopup> createState() => _MusicMachinePopupState();
}

class _MusicMachinePopupState extends State<MusicMachinePopup> {
  String _selection = AppIcons.icon1;
  @override
  Widget build(BuildContext context) {
    return    PopupMenuButton<String>(itemBuilder: (context) => [AppIcons.icon1,AppIcons.icon2, AppIcons.icon3, AppIcons.icon4,]
      .map((e) => PopupMenuItem<String>(child: Image.asset(e,width: 30.0,))).toList(),
      onSelected: (value) {
        setState(() {
          _selection = value;
        });
      },
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      icon:Image.asset(_selection,width: 30.0,), color: AppColor.scaffoldBackgroundColor, );
  }
}
/*
[
PopupMenuItem<Image>(child: Image.asset(AppIcons.icon1,width: 30.0,)),
PopupMenuItem<Image>(child: Image.asset(AppIcons.icon2,width: 30.0,)),
PopupMenuItem<Image>(child: Image.asset(AppIcons.icon3,width: 30.0,)),
PopupMenuItem<Image>(child: Image.asset(AppIcons.icon4,width: 30.0,)),
]*/
