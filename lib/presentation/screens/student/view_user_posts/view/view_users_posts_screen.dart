import 'package:flutter/material.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/user_post/view.dart';
import 'package:rababa/presentation/screens/student/another_user_screen/view/anthor_student_profile.dart';
import 'package:rababa/presentation/screens/student/view_user_posts/view_model/view_users_posts_view_model.dart';

import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/color_manager.dart';
import '../../add_comment/view_model/add_comment_view_model.dart';
import '../../teacher_profile_screen/view/teacher_profile_view.dart';

class ViewUserPostsScreen extends StatefulWidget {
    ViewUserPostsScreen({Key? key , required this.user}) : super(key: key);
  UserModel user ; 
  @override
  State<ViewUserPostsScreen> createState() => _ViewUserPostsScreenState();
}

class _ViewUserPostsScreenState extends State<ViewUserPostsScreen> {

  final ViewUsersPostsViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.getPosts(widget.user.uid!);
     _viewModel.postsOutput.listen((event) {
       if (widget.user.userType ==
           UserType.teach.userString()) {
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => TeacherProfileView(
                 user: widget.user,
               ),
             ));
       } else {
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => AnotherStudentProfile(
                   user: widget.user, posts: []),
             ));   }
     }) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: AppColor.scaffoldBackgroundColor,
        width: double.infinity,
        height: double.infinity,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidget(), (){
                _viewModel.getPosts(widget.user.uid!);
              })?? Container()
          )
      ],
        ),
    );
  }

  _scaffoldWidget()=>StreamBuilder<List<PostModel>?>(
      stream:_viewModel.postsOutput,
      builder: (context, snapshot) {
        var data = snapshot.data;
        return data==null ? Container():  Expanded(
          child: ListView.separated(

              itemBuilder:(context, index) => UserPostItem(postModel: data[index], user: widget.user,posts: data),
              separatorBuilder:(context, index) => Container(),
              itemCount:data.length
          ),
        );
      }
  );
}


