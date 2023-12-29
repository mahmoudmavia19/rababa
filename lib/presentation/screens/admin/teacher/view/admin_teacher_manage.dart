import 'package:flutter/material.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/admin_component/admin_small_button.dart';
import 'package:rababa/presentation/common/component/admin_component/listview_item.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/resources/style/admin_style.dart';
import 'package:rababa/presentation/screens/admin/teacher/view_model/teacher_view_model.dart';

import '../../../../../app/di.dart';

class AdminTeacherManage extends StatefulWidget {
    AdminTeacherManage({Key? key}) : super(key: key);

  @override
  State<AdminTeacherManage> createState() => _AdminTeacherManageState();
}

class _AdminTeacherManageState extends State<AdminTeacherManage> {

  final TeacherViewModel _viewModel = instance();

  @override
  void initState() {
    _viewModel.getAllTeacher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,),
      body: Column(
        children: [
          ScreenTitle(title: AppStrings.teacherManage) ,
          const SizedBox(height: 20.0,),
        Expanded(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, widgets(), (){})??Container(),),
        )
        ],
      ),
    );
  }

  widgets()=>StreamBuilder<List<UserModel>?>(
     stream: _viewModel.teacherOutput,
    builder: (context, snapshot) {
       var data = snapshot.data;
      return  data!=null ?   RefreshIndicator(
        onRefresh: () async{
          _viewModel.getAllTeacher();
        },
        child: ListView.builder(itemBuilder: (context, index) =>
          ListViewItem(title: AppStrings.teacherName, subtitle: data[index].name??"",
        adminSmallButtonStyle: AdminSmallButtonStyle(width: 95 , height:  32 , radius: 10.0),
        buttonContent:
        Row(children: [
          Image.asset(AppIcons.blockUser , width: 20.0 ,height: 21.0, ) ,
          const SizedBox(width: 10.0,),
          Text(  data[index].isBlocked==null ||!data[index].isBlocked! ?   AppStrings.block  :  AppStrings.unblock, style:  AdminStyle.body20),
        ]),
        onTap: () async{
           await _viewModel.blockTeacher(index);
          print(data[index].isBlocked) ;
        },isLast: (data.length-1)==index,),itemCount: data.length,),
      ) : Container();
    },
  ) ;
}
