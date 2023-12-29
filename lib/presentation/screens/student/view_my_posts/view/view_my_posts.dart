import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/presentation/common/component/my_post/view/my_post_item.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view_model/student_profile_view_model.dart';

import '../../../teacher/teahcer_profile/view/teacher_profile.dart';
import '../../add_comment/view_model/add_comment_view_model.dart';
import '../../profile_screen/view/student_user_profile.dart';

class ViewMyPostsScreen extends StatefulWidget {
   ViewMyPostsScreen({Key? key}) : super(key: key);

  @override
  State<ViewMyPostsScreen> createState() => _ViewMyPostsScreenState();
}

class _ViewMyPostsScreenState extends State<ViewMyPostsScreen> {
  final StudentProfileViewModel _viewModel = instance();
  final AddCommentViewModel _viewModelPosts = instance();

  @override
  void initState() {
    _viewModelPosts.getPosts();
    super.initState();
  }
  @override
  void dispose() {
    print('close') ;
      UserProfile.viewModel.getLovePosts();
      UserProfile.viewModel.getPosts();
    TeacherProfile.viewModel.getLovePosts();
    TeacherProfile.viewModel.getPosts();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Column(
          children: [
            const Text(AppStrings.posts),
            const SizedBox(height: 10.0,) ,
            Text(AppConstant.userObject!.username!)
          ],
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.postsState.stream,
        builder:(context, snapshot) => snapshot.data?.getScreenWidget(context,_stream(), (){
          _viewModelPosts.getPosts();
        })??_stream()
      )
    );
  }

  _stream()=>StreamBuilder<FlowState>(
      stream: _viewModelPosts.postsState.stream,
      builder: (context, snapshot) => snapshot.data?.getScreenWidget(context,_scaffoldWidget(), (){
        _viewModelPosts.getPosts();
      })??Container()
  );

  _scaffoldWidget()=>StreamBuilder<List<PostModel>?>(
      stream:_viewModelPosts.postsStreamController.stream,
      builder: (context, snapshot) {
        var data = snapshot.data;
        return data==null ? Container():  ListView.separated(
            itemBuilder:(context, index) => MyPostItem(postModel: data[index], deleteTap: () {
              _viewModel.deletePost(data[index]);
            },),
            separatorBuilder:(context, index) => Container(),
            itemCount:data.length
        );
      }
  );
}
