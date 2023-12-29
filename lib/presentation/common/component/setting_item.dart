import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
    SettingItem({Key? key  , required this.title , required this.onTap}) : super(key: key);
    String title ;
    GestureTapCallback onTap ;
  @override
  Widget build(BuildContext context) {
    return  ListTile(title: Text(title,style: Theme.of(context).textTheme.bodyLarge,), onTap:onTap,
      trailing: const Icon(Icons.arrow_forward_ios),textColor: Colors.black,) ;
  }
}
