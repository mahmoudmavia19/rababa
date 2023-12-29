import 'package:flutter/material.dart';
import 'package:rababa/app/extentions.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/admin_component/admin_small_button.dart';
import 'package:rababa/presentation/common/component/admin_component/listview_item.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/resources/style/admin_style.dart';
import 'package:rababa/presentation/screens/admin/teacher/view_model/teacher_view_model.dart';

import '../../../../../app/di.dart';

class AdminTeacherDetails extends StatefulWidget {
    AdminTeacherDetails({Key? key, required this.teacher ,required this.index}) : super(key: key);
    UserModel teacher ;
    int index  ;

  @override
  State<AdminTeacherDetails> createState() => _AdminTeacherDetailsState();
}

class _AdminTeacherDetailsState extends State<AdminTeacherDetails> {

  final TeacherViewModel _viewModel = instance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, toolbarHeight: 30.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenTitle(title: AppStrings.teacherData),
            const SizedBox(height: 20.0,),
            ListViewItem(title: AppStrings.name2, subtitle: widget.teacher.name??''),
            ListViewItem(title: AppStrings.email2, subtitle: widget.teacher.email??''),
            ListViewItem(title: AppStrings.country, subtitle: widget.teacher.country??''),
            ListViewItem(title: AppStrings.certificate,
                subtitle: widget.teacher.country??''),
            ListViewItem(title: AppStrings.machines, subtitle: widget.teacher.musicInstrument??'', isLast: true,),
            const SizedBox(height: 30.0,) ,
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: StreamBuilder<List<UserModel>?>(
                stream: _viewModel.teacherOutput,
                builder: (context, snapshot) {
                  return widget.teacher.isAccepted.isNull()?  Container() :Row(
                    children: [

                    AdminSmallButton(
                      adminSmallButtonStyle: AdminSmallButtonStyle(height:46.0 ,
                        radius: 10.0,
                        width: 106.0,),
                      title:Text( AppStrings.reject , style: AdminStyle.body36.copyWith(color: const Color(0xFF675896)),), onTap: () {
                /*      Navigator.push(context, MaterialPageRoute(builder:(context) =>   AdminTeacherManage(),)) ;*/
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text(' تم رفض المعلم'),backgroundColor: AppColor.primary[600],duration: const Duration(milliseconds: 200)),);
                      _viewModel.acceptTeacher(widget.index).then((value){
                     //   Navigator.push(context, MaterialPageRoute(builder:(context) =>   AdminTeacherManage(),)) ;

                      });
                    },
                    enable: widget.teacher.isAccepted.isNull(),),
                    const Spacer() ,

                    AdminSmallButton(
                      adminSmallButtonStyle: AdminSmallButtonStyle(height:46.0 ,
                        radius: 10.0,
                        width: 106.0,),
                      title:Text( AppStrings.accept , style: AdminStyle.body36.copyWith(color: const Color(0xFF675896)),), onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text(' تم قبول المعلم'),backgroundColor: AppColor.primary[600],duration: const Duration(milliseconds: 200)),);                        _viewModel.acceptTeacher(widget.index).then((){

                        });
                    },
                    enable: !widget.teacher.isAccepted.isNull(),
                    ),
                  ],);
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}