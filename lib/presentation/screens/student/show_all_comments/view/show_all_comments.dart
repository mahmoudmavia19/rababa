import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/show_all_comments/view_model/show_comments_view_model.dart';

import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/post_model.dart';

class ShowAllComments extends StatefulWidget {
  ShowAllComments({Key? key, required this.postModel}) : super(key: key);
  PostModel postModel;
  @override
  State<ShowAllComments> createState() => _ShowAllCommentsState();
}

class _ShowAllCommentsState extends State<ShowAllComments> {
  ShowCommentsViewModel? _viewModel;

  @override
  void initState() {
    _viewModel = ShowCommentsViewModel(widget.postModel, instance());
    _viewModel!.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.comments),
      ),
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: StreamBuilder<FlowState>(
            stream: _viewModel!.outputState,
            builder: (context, snapshot) =>
                snapshot.data
                    ?.getScreenWidget(context, _scaffoldWidget(), () {
                      _viewModel!.getAllComments();
                }) ??
                Container(),
          )),
    );
  }

  _scaffoldWidget() => StreamBuilder<List<Map<String,dynamic>>>(
      stream: _viewModel!.commentOutput,
      builder: (context, snapshot) {
        var data = snapshot.data;
        return data == null
            ? Container()
            : ListView.builder(
                itemBuilder: (context, index) {
                  var two = data[index].keys.toList();
                  CommentModel comment = data[index][two[0]];
                  UserModel user = data[index][two[1]];
                  return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: user.imgUrl == null ? AssetImage(
                      AppIcons.defaultImg,
                    ) as ImageProvider :NetworkImage(
                      user.imgUrl!,
                    ) ,
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                            '${user.name}',overflow: TextOverflow.ellipsis,),
                      ),
                      Text(
                          ' ${date.DateFormat.yMMMd(AppConstant.ar).format(comment.date!)}' , style: Theme.of(context).textTheme.caption,),
                    ],
                  ),

                  subtitle: Text(comment.comment ?? ''),
                );
                },
                itemCount: data.length,
              );
      });
}
