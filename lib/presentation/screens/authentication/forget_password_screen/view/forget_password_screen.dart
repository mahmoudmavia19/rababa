import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/component/email_form_faild.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/forget_password_screen/view_model/forget_password_view_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
    ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
   final ForgetPasswordViewModel _viewModel = instance();
 @override
  void dispose() {
    _viewModel.dispose() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
          leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back_ios))),
        body:Directionality(
          textDirection: TextDirection.rtl,
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidgets(), (){
              Navigator.pop(context);
            })??_scaffoldWidgets(),
          ),
        ),
      ),
    );
  }

  _scaffoldWidgets()=>StreamBuilder<String>(
    stream: _viewModel.forgetPasswordStreamController.stream,
    builder: (context, snapshot) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              CustomTextField(title: AppStrings.email , onChanged: (value) {
                _viewModel.setEmail(value);
              },
              formatters: [
                AppConstant.engREX
              ],
              ),
              const SizedBox(height: 50.0,) ,
              CustomButton(title: AppStrings.send, onTap: (){
                _viewModel.forgetPassword() ;
              })
            ],
          ),
        ),
      );
    }
  );
}
