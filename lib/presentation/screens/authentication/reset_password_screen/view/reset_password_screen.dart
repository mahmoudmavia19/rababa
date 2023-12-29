import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/password_form_faild.dart';
import 'package:rababa/presentation/common/component/password_form_faild.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/reset_password_screen/view_model/reset_password_view_model.dart';
 import '../../../../resources/assets_manager.dart';

import '../../../../resources/color_manager.dart' ;

class ResetPasswordScreen extends StatefulWidget {
    const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
 final  ResetPasswordViewModel _viewModel = instance();

 @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   var data = AppConstant.userObject ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2ADD5),
        elevation: 0.0,
      ),
      backgroundColor: AppColor.scaffoldBackgroundColor2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppIcons.background2 ,width: double.infinity,fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    width: double.infinity,
                    height:150,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius:31.71,
                              backgroundColor: Colors.white,
                              backgroundImage: data!.imgUrl!=null ? NetworkImage(data.imgUrl!) as ImageProvider : AssetImage(AppIcons.defaultImg),
                            ),
                            const SizedBox(width: 10.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppConstant.userObject!.name!,style: Theme.of(context).textTheme.bodyLarge,),
                                Text('@${AppConstant.userObject!.username!}',style: Theme.of(context).textTheme.bodyLarge,),
                              ],
                            ),
                            /*const Spacer(),
                            IconButton( onPressed: () {

                            },  icon: const Icon(Icons.arrow_forward_ios)),
                            const SizedBox(width: 10.0,),*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
         StreamBuilder<FlowState>(
           stream: _viewModel.outputState,
             builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidgets(context), (){
               if(snapshot.data?.getStateRendererType() == StateRendererType.fullScreenSuccessState)
                 {
                   Navigator.pop(context);
                 }
             }) ?? _scaffoldWidgets(context),
         )
          ],
        ),
      ),
    ) ;
  }

  _scaffoldWidgets(context)=>Padding(
    padding: const EdgeInsets.all(50.0),
    child: Column(
      children: [
        PasswordFormField(title: AppStrings.oldPassword, onChanged: (value) {
          _viewModel.oldPassword = value;
        },),
        const  SizedBox(height: 20.0,) ,
        PasswordFormField(title: AppStrings.newPassword, onChanged: (value) {
          _viewModel.newPassword = value;
        },),
        const  SizedBox(height: 20.0,) ,
        PasswordFormField(title: AppStrings.reNewPassword , onChanged: (value) {
          _viewModel.rePassword = value ;
        },),
        const  SizedBox(height: 20.0,) ,
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)
          ),
          width: double.infinity,
          child: MaterialButton(onPressed: (){
            _viewModel.changePassword();
          },
            color: AppColor.primary[600],
            child: const Text(AppStrings.ok ,style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 38.0), ),),
        )
      ],
    ),
  );
}
