import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/app/fire_base_dynamic_link.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/isliked_post_usecase.dart';
import 'package:rababa/domain/usecase/love_post_usecase.dart';
import 'package:rababa/presentation/common/component/user_post/view_model.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/screens/student/add_comment/view/add_commint_screen.dart';
import 'package:rababa/presentation/screens/student/another_user_screen/view/anthor_student_profile.dart';
import 'package:rababa/presentation/screens/student/create_post_screen/view_model/create_post_view_model.dart';
import 'package:share/share.dart';
import '../../../../../domain/usecase/share_post_usecase.dart';
import '../../../../../domain/usecase/update_post_usecase.dart';
import '../../../screens/student/show_all_comments/view/show_all_comments.dart';
import '../../../screens/student/teacher_profile_screen/view/teacher_profile_view.dart';
 import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class UserPostItem extends StatefulWidget {
  UserPostItem(
      {Key? key,
      required this.postModel,
      required this.user,
      required this.posts})
      : super(key: key);
  PostModel postModel;
  List<PostModel> posts;
  UserModel user;
  @override
  State<UserPostItem> createState() => _UserPostItemState();
}

class _UserPostItemState extends State<UserPostItem> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  final UserPostViewModel _viewModel = UserPostViewModel(
      SharePostUseCase(instance()),
      UpdatePostUseCase(instance()),
      IsLikedUseCase(instance()),
      LovePostUseCase(instance()),
      instance());
  final CreatePostViewModel _shareViewModel = instance();
  @override
  void initState() {
    _viewModel.postCon.add(widget.postModel);
    _viewModel.post = widget.postModel;
    _viewModel.start();
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.postModel.postVideo!);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    /* _videoPlayerController.dispose();
    _chewieController.dispose();
    _viewModel.postCon.close();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostModel>(
        stream: _viewModel.postCon.stream,
        builder: (context, snapshot) {
          var data = snapshot.data;
          return data == null
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
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
                                        user: widget.user, posts: widget.posts),
                                  ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: widget.user.imgUrl != null
                                      ? NetworkImage(widget.user.imgUrl!)
                                          as ImageProvider
                                      : AssetImage(AppIcons.defaultImg),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  widget.user.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontFamily:
                                              AppConstant.fontFamilyRoboto),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Chewie(
                                  controller: _chewieController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            const SizedBox(width: 20.0),
                            InkWell(
                              child: Image.asset(
                                AppIcons.love,
                                color: _viewModel.isLike! ? Colors.red : null,
                              ),
                              onTap: () {
                                _viewModel.like();
                              },
                            ),
                            const SizedBox(width: 20.0),
                            InkWell(
                              child: Image.asset(AppIcons.comment),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AddCommentScreen(postModel: data),
                                    ));
                              },
                            ),
                            const SizedBox(width: 20.0),
                            InkWell(
                              child: Image.asset(
                                AppIcons.send,
                              ),
                              onTap: () {
                                DynamicLinkProvider()
                                    .createLink(widget.postModel.id!)
                                    .then((value) {
                                  Share.share(value);
                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              Text(
                                '${data.likes.length}Likes',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontFamily:
                                            AppConstant.fontFamilyRoboto,
                                        color: Colors.black),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Text(
                                    AppConstant.userObject!.username!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontFamily:
                                                AppConstant.fontFamilyRoboto,
                                            color: Colors.black),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Text(
                                    widget.postModel.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontFamily:
                                                AppConstant.fontFamilyRoboto,
                                            color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ShowAllComments(
                                            postModel: widget.postModel,
                                          ),
                                        ));
                                  },
                                  child: Text(
                                    'View all ${data.comments!.length} comments',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                            fontFamily:
                                                AppConstant.fontFamilyRoboto),
                                  )),
                              const SizedBox(height: 10.0),
                              Text(
                                df.DateFormat.yMMMd().format(data.date!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.0,
                                        color: Colors.grey,
                                        fontFamily:
                                            AppConstant.fontFamilyRoboto),
                              ),
                            ],
                          ),
                        )
                      ]),
                );
        });
  }
}
