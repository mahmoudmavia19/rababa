import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as df;
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/domain/usecase/isliked_post_usecase.dart';
import 'package:rababa/domain/usecase/love_post_usecase.dart';
import 'package:rababa/presentation/common/component/my_post/view_model/my_post_view_model.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/add_comment/view/add_commint_screen.dart';
import 'package:rababa/presentation/screens/student/show_all_comments/view/show_all_comments.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/fire_base_dynamic_link.dart';
import '../../../../../domain/usecase/delete_post_usecase.dart';
import '../../../../../domain/usecase/share_post_usecase.dart';
import '../../../../../domain/usecase/update_post_usecase.dart';
import '../../../../video_screen/video_screen.dart';

class MyPostItem extends StatefulWidget {
  MyPostItem({Key? key , required this.postModel , required this.deleteTap}) : super(key: key);
  PostModel postModel;
  VoidCallback? deleteTap ;
  @override
  State<MyPostItem> createState() => _MyPostItemState();
}

class _MyPostItemState extends State<MyPostItem> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  final MyPostViewModel _viewModel = MyPostViewModel(
      SharePostUseCase(instance()), DeletePostUseCase(instance()),
      UpdatePostUseCase(instance()),IsLikedUseCase(instance()),LovePostUseCase(instance()));
  @override
  void initState() {
    _viewModel.postCon.add(widget.postModel);
    _viewModel.post = widget.postModel ;
    _viewModel.start() ;
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
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _viewModel.postCon.close() ;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostModel>(
        stream: _viewModel.postCon.stream,
        builder: (context, snapshot) {
          var data = snapshot.data ;
          return data == null ? Container() : SizedBox(
            width: double.infinity,
            child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        CircleAvatar(radius: 25,backgroundImage:AppConstant.userObject!.imgUrl!=null?
                        NetworkImage(AppConstant.userObject!.imgUrl!) as ImageProvider
                            : AssetImage(AppIcons.defaultImg),),
                        const SizedBox(width: 10.0,),
                        Text(AppConstant.userObject!.name!,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: AppConstant.fontFamilyRoboto),),
                        const Spacer(),
                        PopupMenuButton<String>(itemBuilder: (context) =>[
                          PopupMenuItem<String>(child:const Text(AppStrings.share),onTap: () {
                            DynamicLinkProvider().createLink(widget.postModel.id!).then((value) {
                              Share.share(value);
                            });
                          },),
                          PopupMenuItem<String>(onTap:widget.deleteTap,child: const Text(AppStrings.delete),),
                        ] , icon: const Icon(Icons.more_horiz),)
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.5,
                        child: AspectRatio(
                          aspectRatio:
                          _videoPlayerController.value.aspectRatio,
                          child: Chewie(
                            controller: _chewieController,
                          ),
                        ),
                      ),
                 /*     SizedBox(
                        width: double.infinity,
                        height: 244.0,
                        child: Image.network(data.postImg!,
                          width: double.infinity,
                          height: 244.0,fit: BoxFit.cover, ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: widget.postModel.postVideo!),));
                        },
                          child: Image.asset(AppIcons.pause))*/
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      const SizedBox(width: 20.0)  ,
                      InkWell(child: Image.asset(AppIcons.love , color:_viewModel.isLike!? Colors.red : null,) ,
                        onTap: (){
                          _viewModel.like();
                        },),
                      const SizedBox(width: 20.0)  ,
                      InkWell(child: Image.asset(AppIcons.comment) ,onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddCommentScreen(postModel: data) ,));
                      },) ,
                      const SizedBox(width: 20.0)  ,
                      InkWell(child: Image.asset(AppIcons.send,), onTap: (){
                        DynamicLinkProvider().createLink(widget.postModel.id!).then((value) {
                          Share.share(value);
                        });
                      },) ,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0)  ,
                        Text('${widget.postModel.likes.length}Likes',style:Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: AppConstant.fontFamilyRoboto, color: Colors.black),),
                        const SizedBox(height: 10.0)  ,
                        Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            Text(AppConstant.userObject!.username!, style:Theme.of(context).textTheme.bodySmall!.copyWith(fontFamily: AppConstant.fontFamilyRoboto, color: Colors.black),),
                            const SizedBox(width:20.0),
                            Text(widget.postModel.title! ,style:Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal,fontFamily: AppConstant.fontFamilyRoboto , color: Colors.black),),
                          ],),
                        const SizedBox(height: 10.0)  ,
                        InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAllComments(postModel: data,),));
                            },
                            child: Text('View all ${data.comments!.length} comments',style:Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey ,fontSize: 11.0,fontFamily: AppConstant.fontFamilyRoboto),)),
                        const SizedBox(height: 10.0)  ,
                        Text(df.DateFormat.yMMMd().format(data.date!), style:Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal,fontSize: 10.0,color: Colors.grey ,fontFamily: AppConstant.fontFamilyRoboto),),
                      ],
                    ),
                  )
                ]),
          );
        }
    );
  }
}
