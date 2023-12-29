import 'package:flutter/material.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/compare_teachers.dart';
import 'package:rababa/presentation/screens/student/teacher_profile_screen/view/teacher_profile_view.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

class TeacherItemView extends StatefulWidget {
    TeacherItemView({super.key ,required this.user, required this.select ,required this.action});
  bool select = false ;
  UserModel user ;
  ValueChanged<bool>? action ;
  @override
  State<TeacherItemView> createState() => _TeacherItemViewState();
}

class _TeacherItemViewState extends State<TeacherItemView> {
  bool isSelected = false ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor:AppColor.primary[600],
      onTap: () {
        if(!widget.select) {
          if(Navigator.canPop(context)){
            Navigator.pop(context);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) =>   TeacherProfileView(user: widget.user),));
        }else {
          setState(() {
            isSelected = !isSelected;
          });
          if( widget.action!=null) {
            widget.action!(isSelected);
          }
        }
      },

      child: Container(
        padding: const EdgeInsets.all(10.0),
        color:isSelected && widget.select? AppColor.selectedItemColor:  null,
        height: 140.0,
        child: Row(
          children: [
            CircleAvatar(
              radius:40,
              backgroundColor: Colors.white,
              backgroundImage:widget.user.imgUrl==null ? AssetImage(AppIcons.defaultImg) as ImageProvider:  NetworkImage(widget.user.imgUrl!),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.user.name??'',style: Theme.of(context).textTheme.bodyLarge,),
                  Text(widget.user.country??'',style: Theme.of(context).textTheme.bodyMedium,),
                  Row(
                    children:   [
                      const Icon(Icons.star,color: AppColor.starColor,size: 15.0,),
                      Text('${widget.user.rate??0.0}',style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                  Text('سعر الساعة ${widget.user.price??'0.0 SR'}',style: Theme.of(context).textTheme.bodyMedium,) ,
                  Expanded(
                    child: Text(widget.user.certificate!=null ? ' حاصل علي ${widget.user.certificate??''}'  : '',
                        overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium),
                  )
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                    child: const Image(image:AssetImage('assets/images/getar.png') , height: 100,width: 60.0 , fit: BoxFit.cover,)),
                Image(image:AssetImage(AppIcons.pause) , height: 30,width: 30.0 , fit: BoxFit.cover,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
