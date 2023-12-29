import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/create_post_screen/view_model/create_post_view_model.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

 final CreatePostViewModel _viewModel = instance();
  _bind(){
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   print('close') ;
   ScaffoldMessenger.of(context).hideCurrentSnackBar();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.createPost,),
      ),
      body:StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
          builder:(context, snapshot) =>
              snapshot.data?.getScreenWidget(context, _scaffoldWidgets(context), (){
                    AppConstant.pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInSine).then((value) {
                    });
              }) ??
                  _scaffoldWidgets(context),
      )

    );
  }

  _scaffoldWidgets(context)=>StreamBuilder<PostModel>(
    stream: _viewModel.postOutput,
    builder: (context, snapshot) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.description,style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 20.0,),
            TextFormField(
              maxLines: 3,
              onChanged: (value) {
                _viewModel.setDescription(value);
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20.0,),
            Row(
              children: [
                Text(AppStrings.addVideo,style: Theme.of(context).textTheme.bodyLarge,),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0 , color: Colors.grey)
                    ),
                    child: TextButton(
                        onPressed: (){
                          _viewModel.setVideo();
                        },
                        child: Icon(Icons.add, color: AppColor.primary[600],)
                    ),
                  ),
                )) ,
              ],
            ),
            const SizedBox(height: 20.0,),
            StreamBuilder<File>(
              stream: _viewModel.stackerOutput,
                builder:(context, snapshot) => snapshot.hasData ?
                Image.file(snapshot.data!, width: double.infinity,height: 300.0,fit: BoxFit.cover,) : Container(), ) ,

            CustomButton(title: AppStrings.add, onTap: () {
              _viewModel.createPost();
            },)
          ],
        ),
      );
    }
  ) ;
}
