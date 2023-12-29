import 'package:flutter/material.dart';
import 'package:rababa/data/model/user_model.dart';

import '../../../data/model/post_model.dart';
import '../../common/component/user_post/view.dart';

class ShowUserPosts extends StatelessWidget {
    ShowUserPosts({Key? key, required this.posts, required this.user}) : super(key: key);
  List<PostModel> posts ;
  UserModel user ;
  @override
  Widget build(BuildContext context) {
    var data = posts ;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username??''),
      ),
      body:  Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder:(context, index) => UserPostItem(postModel: data[index], user: user,posts: data),
                separatorBuilder:(context, index) => Container(),
                itemCount:data.length
            ),
          ),
        ],
      ),
    ) ;
  }
}
