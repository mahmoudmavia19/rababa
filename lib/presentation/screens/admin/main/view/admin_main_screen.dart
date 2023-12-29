import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/admin/pay/view/admin_operations_pay.dart';
import 'package:rababa/presentation/screens/admin/shops/view/admin_shops.dart';
import 'package:rababa/presentation/screens/admin/teacher/view/admin_teacher_manage.dart';
import 'package:rababa/presentation/screens/admin/teacher/view/admin_teacher_view.dart';
import '../../../../common/component/admin_component/admin_button.dart';
import '../../../../resources/style/admin_style.dart';
import '../../complaint_screen/view/admin_complaint.dart';
import '../view_model/main_view_model.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  final AdminMainViewModel _viewModel = instance();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(elevation: 0.0),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
               Container(
                   width: 106,
                   height: 46,
                   decoration:   BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: const Color(0xFFCFB2C1)
                   ),
                   child: Center(child: Text(AppStrings.manage, style:AdminStyle.body36.copyWith(color: AppColor.primary[600]),))) ,
               SizedBox(height:MediaQuery.of(context).size.height*0.2,),
              AdminButton(title: AppStrings.theTeacher, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminTeacherView(),));
              },),
              const SizedBox(height: 20.0,),
              AdminButton(title: AppStrings.teacherManage, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminTeacherManage(),));

              },) ,
              const SizedBox(height: 20.0,),
              AdminButton(title: AppStrings.payments, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminOperationsPay(),));

              },),
              const SizedBox(height: 20.0,),
              AdminButton(title: AppStrings.complaint, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminComplaint(),));

              },),
              const SizedBox(height: 20.0,),
              AdminButton(title: AppStrings.shops, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminShops(),));

              },) ,
              const SizedBox(height: 20.0,),

              AdminButton(title: AppStrings.logout, onTap: () {
                _viewModel.logoutCon.stream.listen((event) {
                  if(event){
                    /*  SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OnBoardingScreen(),), (route) => false);
          });*/
                    Phoenix.rebirth(context);
                  }
                });
                _viewModel.logout();

              },) ,


            ],
          ),
        ),
      ),
    );
  }

}
