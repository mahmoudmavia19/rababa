import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rababa/app/end_points/constant.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key, required this.title, this.subTitle , this.onChanged , this.enabled = true , this.suffixIcon , this.controller ,this.formatters } ) : super(key: key);
  String title ;
  String? subTitle ;
  bool enabled ;
  Widget? suffixIcon ;
  ValueChanged<String>? onChanged ;
  TextEditingController? controller ;
  List<TextInputFormatter>? formatters ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style:Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal),),
          ],
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          enabled: enabled,
          inputFormatters: formatters ,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: AppConstant.fontFamilyRoboto),
          decoration: InputDecoration(
              hintText:subTitle,
            suffixIcon: suffixIcon,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey , fontFamily: AppConstant.fontFamilyRoboto),
          ),
        ),
      ],
    );
  }
}
