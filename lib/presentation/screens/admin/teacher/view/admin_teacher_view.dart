import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/resources/style/admin_style.dart';
import 'package:rababa/presentation/screens/admin/teacher/view/admin_teacher_details.dart';
import 'package:rababa/presentation/screens/admin/teacher/view_model/teacher_view_model.dart';
import '../../../../common/component/admin_component/admin_small_button.dart';
import '../../../../common/component/admin_component/listview_item.dart';
import '../../../../common/component/admin_component/screen_title.dart';

class AdminTeacherView extends StatefulWidget {
  const AdminTeacherView({Key? key}) : super(key: key);

  @override
  State<AdminTeacherView> createState() => _AdminTeacherViewState();
}

class _AdminTeacherViewState extends State<AdminTeacherView> {
  final TeacherViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, toolbarHeight: 30.0),
      body:SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ScreenTitle(title: AppStrings.theTeacher),
            const SizedBox(height: 20.0,),
            Expanded(
              child: StreamBuilder<FlowState>(
                stream: _viewModel.outputState,
                  builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, widgets(context),(){})??Container(),),
            )
          ],
        ),
      ),
    ); 
  }

  widgets(context)=> StreamBuilder<List<UserModel>?>(
    stream: _viewModel.teacherOutput,
    builder: (context, snapshot) {
      var data = snapshot.data; 
      return data!=null ?RefreshIndicator(
        onRefresh: () async{
          _viewModel.getAllTeacher();
        },
        child: ListView.builder(itemBuilder: (context, index) =>  ListViewItem(
            title: AppStrings.teacherName, subtitle: data[index].name! ,
            buttonContent: Text(AppStrings.viewDetails, style:AdminStyle.body16,) ,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdminTeacherDetails(teacher: data[index],index: index),));
            },isLast: (data.length-1)==index) , itemCount: data.length,),
      ): Container();
    },
  ) ; 
}
