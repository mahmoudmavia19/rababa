import 'package:flutter/material.dart';

import '../../../resources/style/admin_style.dart';
import 'admin_small_button.dart';

class ListViewItem extends StatelessWidget {
    ListViewItem({Key? key, required this.title ,required this.subtitle ,this.buttonContent, this.onTap , this.isLast= false , this.adminSmallButtonStyle }) : super(key: key);
String title ;
String subtitle ;
Widget? buttonContent ;
AdminSmallButtonStyle? adminSmallButtonStyle ;
VoidCallback? onTap ;
bool isLast ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Text(title, style: AdminStyle.body24,),
              Text(subtitle,style: AdminStyle.body24,),
              const Spacer(),
              buttonContent==null ? Container() : AdminSmallButton(title: buttonContent!, onTap: onTap!,adminSmallButtonStyle: adminSmallButtonStyle,)
            ],
          ),
        ),
        if(isLast)
        const Divider(thickness: 1.0),
      ],
    );
  }
}
