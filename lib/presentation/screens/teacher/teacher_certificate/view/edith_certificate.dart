import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/screens/teacher/teacher_certificate/view_model/teacher_certificate_view_model.dart';

import '../../../../common/component/customButton.dart';
import '../../../../common/component/email_form_faild.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';

class EditCertificate extends StatelessWidget {
    EditCertificate({Key? key}) : super(key: key);
  final TeacherCertificateViewModel _viewModel = instance();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(elevation: 0.0,),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(AppIcons.registerTopImage , width: double.infinity , fit: BoxFit.cover,),
            StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
                builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(), (){
                  Navigator.pop(context);
                })??_scaffold(),)
          ],
        ),
      )  ,
    );
  }
    _scaffold()=>  Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          StreamBuilder<XFile?>(
              stream: _viewModel.imgStreamController.stream,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    _viewModel.setImg();
                  },
                  child: CustomTextField(title: AppStrings.certificate2 ,
                    enabled: false,subTitle:snapshot.data==null?  AppStrings.certificateLoad : snapshot.data!.name,
                    suffixIcon: const Icon(Icons.add_box_outlined),),
                );
              }
          ),
          const SizedBox(height: 20.0,),
          CustomTextField(title: AppStrings.writeCertificate ,
            controller: TextEditingController(text:_viewModel.certificateName),
            subTitle:AppStrings.writeCertificate ,
            onChanged: (value) {
            print(value) ;
            _viewModel.setCertificate(value);
            },),
          const SizedBox(height: 30.0,) ,
          CustomButton(title: AppStrings.loadCertificate, onTap: () {
            _viewModel.updateProfile() ;
          },),
        ],
      ),
    );
}
