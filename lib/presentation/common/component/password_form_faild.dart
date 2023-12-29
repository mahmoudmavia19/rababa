import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/end_points/constant.dart';
import '../../resources/assets_manager.dart';

class PasswordFormField extends StatefulWidget {
    PasswordFormField({Key? key, required this.title  , this.onChanged}) : super(key: key);
  String title ;
    ValueChanged<String>? onChanged ;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isPassword = true ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),),
          ],
        ),
        TextFormField(
          obscureText: isPassword,
          onChanged: widget.onChanged,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[~!@#$%^&*()_+=[\]\\{}|;:".\/<>?a-zA-Z0-9-]+$')),
           ],
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: AppConstant.fontFamilyRoboto),
          decoration: InputDecoration(
              hintText:'8 احرف على الأقل' ,
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
              suffixIcon: IconButton(onPressed: () {
                isPassword = !isPassword ;
                 setState(() {

                 });
              }, icon:isPassword ? Image.asset(AppIcons.isPassword) : const Icon(Icons.remove_red_eye_outlined))
          ),
        ),
      ],
    );
  }
}
