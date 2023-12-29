import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/screens/student/another_user_screen/view_model/another_user_view_model.dart';
import 'package:rababa/presentation/screens/student/chat/view/chat_screen.dart';
import 'package:rababa/presentation/screens/student/show_users/view/show_users.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../show_user_posts.dart';

class AnotherStudentProfile extends StatefulWidget {
   AnotherStudentProfile({Key? key , required this.user,required this.posts}) : super(key: key);
   UserModel user ;
   List<PostModel> posts ;

  @override
  State<AnotherStudentProfile> createState() => _AnotherStudentProfileState();
}

class _AnotherStudentProfileState extends State<AnotherStudentProfile> {
   late final AnotherUserViewModel? _viewModel ;

   @override
  void initState() {
     _viewModel = AnotherUserViewModel(instance() ,instance() ,instance() , widget.user);
     _viewModel!.start();
     _viewModel!.getUserPosts() ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(

      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(itemBuilder: (context) =>[
            PopupMenuItem<String>(child:   Text(_viewModel!.isBlocked? AppStrings.unblock: AppStrings.block), onTap: () {
              _viewModel!.blocking();
            },),

        /*    PopupMenuItem<String>(child: const Text(AppStrings.share), onTap: () {

            },),*/
          ], icon: const Icon(Icons.more_horiz, color: Colors.black,),color: AppColor.scaffoldBackgroundColor,)
        ],
        backgroundColor: AppColor.appBarProfileColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.user.username!,),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppIcons.background1, width: double.infinity ,fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    //color: AppColor.appBarProfileColor,
                    width: double.infinity,
                    height:200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius:31.71,
                                  backgroundColor: Colors.white,
                                  backgroundImage: widget.user.imgUrl!=null ? NetworkImage(widget.user.imgUrl!)as ImageProvider  :  AssetImage(AppIcons.defaultImg,),
                                ),
                                const SizedBox(height: 10.0,),
                                Text(widget.user.name!,style: Theme.of(context).textTheme.bodyLarge,),
                                const SizedBox(height: 10.0,),
                              ],
                            ),
                            const SizedBox(width: 20.0,),
                            Column(
                              children:  [
                                //   SizedBox(height: 5.0,),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Text(widget.user.bio!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18.0 , color: Color.fromRGBO(0, 0, 0, 0.71)),overflow: TextOverflow.visible,),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        StreamBuilder<bool>(
                          stream: _viewModel!.isBlocking.stream,
                          builder: (context, snapshot) {
                            return Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Icon(Icons.message_rounded, color:  AppColor.primary[600],),
                                    IconButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userModel:widget.user),)) ;
                                    }, icon: Image.asset(AppIcons.message , color: AppColor.primary,) ,),
                                    const SizedBox(width: 20.0,),
                                    StreamBuilder<bool>(
                                      stream:_viewModel!.isFollowing.stream ,
                                      builder: (context, snapshot) {
                                        bool? data = snapshot.data;
                                        return  data ==null ?Container() :  Container(
                                          height: 25.0,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          width: 213,
                                          child: MaterialButton(onPressed: (){
                                            _viewModel!.following();

                                          },
                                            color: AppColor.primary,
                                            child:   data ? const Text(AppStrings.unFollowing ,style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 24.0), ) : const Text(AppStrings.following ,style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 24.0), )
                                            ,),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                if(snapshot.data==true)
                                  BlurryContainer(
                                    blur: 5,
                                    width: double.infinity,
                                    height: 50,
                                    elevation: 0,
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.all(8),
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    child: Container(),
                                  ),
                              ],
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder<bool>(
              stream: _viewModel!.isBlocking.stream,
              builder: (context, snapshot) =>  Stack(
                children: [
                  _widgets(),
                  if(snapshot.data==true)
                    BlurryContainer(
                      blur: 5,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      elevation: 0,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(),
                    ),
                ],
              ) ,)
          ],
        ) ,
      )
    );
  }
_widgets()=>   Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(children: [
    Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
          child: Text('المنشورات ' , style: Theme.of(context).textTheme.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0) , bottomLeft: Radius.circular(30.0))),
            height: 180.0,
            child: StreamBuilder<FlowState>(
              stream: _viewModel!.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getScreenWidget(context, _postsWidget(), (){})??Container() ;
              }
            ),
          ),
        ),
      ],

    )),
    Container(
      decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(25.0)
      ),
      height: 336,
      width: 89,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left:20  , right:  20.0 , bottom: 10.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text((widget.user.likes!.length??0).toString() , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white )),
                  Text('الإعجابات' , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                  const Divider(color: Colors.white,),
                ],
              ),
            ),
            StreamBuilder<bool>(
                stream:_viewModel!.isFollowing.stream ,
                builder: (context, snapshot) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: 'المتابعون', usersId: widget.user.followers!),)) ;
                      },
                      child: Column(
                        children: [
                          Text((widget.user.followers!.length??0).toString()  , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                          Text('المتابعون' ,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                          const Divider(color: Colors.white,),
                        ],
                      ),
                    ),
                  );
                }
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: 'المتابعين', usersId: widget.user.following!),)) ;

                },
                child: Column(
                  children: [
                    Text((widget.user.following!.length??0).toString()  , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                    Text('المتابعين' , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                    const Divider(color: Colors.white,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
  ],),
) ;

   _postsWidget()=>StreamBuilder<List<PostModel>?>(
     stream: _viewModel!.userPosts.stream,
     builder: (context, snapshot) {
       widget.posts = snapshot.data??widget.posts ;
       return InkWell(
         onTap: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ShowUserPosts(posts: widget.posts ,user: widget.user,) ,));

         },
         child: GridView.builder(itemBuilder: (context, index) {

           return Padding(
             padding: const EdgeInsets.all(1.0),
             child: Container(
                 clipBehavior: Clip.antiAlias,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),),
                 child:widget.posts[index].postImg!.substring(0,6)=='assets'?Image.asset(widget.posts[index].postImg!,
                   width: double.infinity,
                   height: 244.0,fit: BoxFit.cover, ) :  Image.network(widget.posts[index].postImg!,width: 109 , height:  89.19,fit: BoxFit.fill, )),
           );
         }, itemCount:widget.posts.length,

           gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ) ,
           physics: const BouncingScrollPhysics(),
           scrollDirection: Axis.horizontal,),
       );
     }
   );
}
