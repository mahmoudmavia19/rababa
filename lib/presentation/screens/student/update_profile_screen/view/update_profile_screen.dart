import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/component/email_form_faild.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view_model/student_profile_view_model.dart';
import '../../../../../app/end_points/constant.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final StudentProfileViewModel _viewModel =instance();
  @override
  void initState() {
    super.initState();
    _viewModel.start();
  }

  @override
  void dispose() {

   _viewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title:   Text(AppStrings.edit , style: Theme.of(context).textTheme.titleLarge,),),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(50.0),
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder:
                (context, snapshot) => snapshot.hasData?
            snapshot.data?.getScreenWidget(context, _scaffoldWidgets(), (){
              if(snapshot.data?.getStateRendererType()==StateRendererType.fullScreenSuccessState)
                {
                  Navigator.pop(context) ;

                }
            }) ?? _scaffoldWidgets(): const Center(child: CircularProgressIndicator()),
          )
      ),

    );
  }

  _scaffoldWidgets()=>StreamBuilder<UserModel?>(
      stream: _viewModel.userOutput,
      builder: (context, snapshot) {
        return Column(
          children: [
            StreamBuilder<XFile?>(
                stream: _viewModel.imgStreamController.stream,
                builder: (context, snapshot) {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage:snapshot.data!=null ?  FileImage(File(snapshot.data!.path)):
                    _viewModel.user.imgUrl!=null ?   NetworkImage(_viewModel.user.imgUrl!)as ImageProvider : AssetImage(AppIcons.defaultImg),
                    onBackgroundImageError: (exception, stackTrace) =>  const NetworkImage("https://via.placeholder.com/150"),
                  );
                }
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: ()  {
                _viewModel.setImg();
              },
              child: const Text(AppStrings.selectProfileImage),
            ),
            CustomTextField(title: AppStrings.name ,subTitle: _viewModel.user.name,onChanged: (value) {
              _viewModel.setName(value) ;
            }, ) ,
            CustomTextField(title:AppStrings.bio,subTitle: _viewModel.user.bio, onChanged: (value) {
              _viewModel.setBio(value) ;

            },  ) ,
            CustomTextField(title: AppStrings.username ,subTitle: _viewModel.user.username,onChanged: (value) {
              _viewModel.setUserName(value) ;
            },),
            const SizedBox(height: 20),
          /*  DropdownButton<String>(
              icon: Image.asset(AppIcons.icon1,width: 30.0,),
              hint:Row(
                children: [
                  const Text('اله العزف'),
                  SizedBox(width: 30.0,)
                ],
              ),
               value: AppIcons.icon1,
               underline: Container(), items:
              [AppIcons.icon1,
              AppIcons.icon2,
              AppIcons.icon3,
              AppIcons.icon4,] .map((e)=>DropdownMenuItem<String>(child: Image.asset(e,width: 30.0,)),).toList()
        , onChanged: (value) {

            },),*/
            StreamBuilder<String?>(
              stream: _viewModel.musicMachine.stream,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    _leanItem(context, AppIcons.learn3,AppConstant.nay),
                    _leanItem(context, AppIcons.learn2,AppConstant.kaman),
                    _leanItem(context, AppIcons.learn1,AppConstant.qanun),
                    _leanItem(context, AppIcons.learn4,AppConstant.oud,),
                  ],
                );
              }
            ) ,
            const SizedBox(height: 20),
            CustomButton(title: AppStrings.save, onTap: () {
              _viewModel.updateProfile();
            },)
          ],
        );
      }
  );
  _leanItem(context, icon,title )=> Expanded(child: InkWell(
    onTap: title == _viewModel.user.musicInstrument?null: (){
      _viewModel.toggle(title) ;
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color:title == _viewModel.user.musicInstrument?null:Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          children: [
            Image.asset(icon),
            const SizedBox(height: 0.5,) ,
            Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),)
          ],
        ),
      ),
    ),
  ));
}
