import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';

import '../../../../data/model/complaint_model.dart';
import '../../../resources/style/admin_style.dart';

class AdminComplaintItem extends StatelessWidget {
    AdminComplaintItem({Key? key ,required  this.complaintModel , this.isLast = false }) : super(key: key);
    ComplaintModel complaintModel ;
    bool isLast ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.0,),
        _lineCom(AppStrings.name2 , complaintModel.name),
        _lineCom(AppStrings.email2 ,complaintModel.email),
        _lineCom(AppStrings.complaint2 , complaintModel.suggestion),
        _lineCom(AppStrings.date ,DateFormat.yMd(AppConstant.ar).format(complaintModel.dateTime!)),
        if(isLast)
        const Divider(thickness: 1.0,),
      ],
    );
  }

  _lineCom(title,subtitle)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    child: Row(
      children: [
        Text(title, style: AdminStyle.body24,),
        SizedBox(width: 5.0,),
        Expanded(child: Text(subtitle,style: AdminStyle.body24,)),
      ],
    ),
  );
}
