import 'package:flutter/material.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';

import '../../../resources/style/admin_style.dart';

class AdminOrderItem extends StatelessWidget {
    AdminOrderItem({Key? key ,required  this.orderModel , this.isLast = false }) : super(key: key);
    OrderModel orderModel ;
    bool isLast ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.0,),
        _lineCom(AppStrings.orderNumber , orderModel.orderNumber),
        _lineCom(AppStrings.teacherName ,orderModel.teacherName),
        _lineCom(AppStrings.studentName , orderModel.studentName),
        _lineCom(AppStrings.total , orderModel.total),
        if(isLast)
        const Divider(thickness: 1.0,),
      ],
    );
  }

  _lineCom(title,subtitle)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    child: Row(
      children: [
        Text(title??'', style: AdminStyle.body24,),
        SizedBox(width: 5.0,),
        Text(subtitle??'',style: AdminStyle.body24,),
      ],
    ),
  );
}
