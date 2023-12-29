import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/add_comment/view_model/add_comment_view_model.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view_model/student_profile_view_model.dart';
import 'package:rababa/presentation/screens/student/view_user_posts/view_model/view_users_posts_view_model.dart';

class AddCommentScreen  extends StatefulWidget {
    AddCommentScreen ({Key? key , required this.postModel}) : super(key: key);
    PostModel postModel ;
  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final AddCommentViewModel _viewModel = instance();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }
  @override
  void dispose() {
/*
    _viewModel.dispose();
*/
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 2.0,),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
         builder: (context, snapshot) => snapshot.data?.getScreenWidget(context,  _scaffoldWidgets(), (){
           if(snapshot.data!.getStateRendererType() == StateRendererType.fullScreenSuccessState)
             {
/*
               instance<StudentProfileViewModel>().getPosts() ;
*/
             _viewModel.getPosts();
/*
             instance<ViewUsersPostsViewModel>().getPosts(widget.postModel.author!);
*/
               Navigator.pop(context);
             }
         })?? _scaffoldWidgets(),
      )
    );
  }

  _scaffoldWidgets()=>Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: widget.postModel.postImg!.substring(0,6)=='assets'? Image.asset(widget.postModel.postImg!,fit: BoxFit.fill,): Image.network(widget.postModel.postImg!,fit: BoxFit.fill,),
                ),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    onChanged: (value) {
                      _viewModel.setCommentString(value);
                    },
                    decoration: const InputDecoration(
                      hintText:AppStrings.writeComment,
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const Divider(thickness: 2.0,),
      Padding(
        padding: const EdgeInsets.all(70.0),
        child: CustomButton(title: AppStrings.post, onTap: (){
          _viewModel.addComment(widget.postModel) ;
        }),
      )
    ],
  );
}
