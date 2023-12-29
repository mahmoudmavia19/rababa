import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/chat/view/chat_list_screen.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view_model/student_profile_view_model.dart';
import 'package:rababa/presentation/screens/student/setting_screen/view/setting_screen.dart';
import 'package:rababa/presentation/screens/student/show_users/view/show_users.dart';
import 'package:rababa/presentation/screens/student/view_my_posts/view/view_my_posts.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';

class UserProfile extends StatefulWidget {
    const UserProfile({Key? key}) : super(key: key);
  static final StudentProfileViewModel viewModel = instance() ;
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  _bind() {
    initUserPostsModule()  ;
    UserProfile.viewModel.start();
   /* UserProfile.viewModel.getLovePosts();
    UserProfile.viewModel.getPosts();*/
  }

  @override
  void dispose() {
   // UserProfile.viewModel.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _bind();

    super.initState();

  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    print('close') ;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<FlowState>(
      stream: UserProfile.viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.hasData? snapshot.data!.getScreenWidget(context, _scaffoldWidgets(context),(){
        UserProfile.viewModel.start();
      }) :
      const Scaffold(body:Center(child:CircularProgressIndicator()),);
      },
    );
  }

  _scaffoldWidgets(context)=>  StreamBuilder<UserModel?>(
    stream: UserProfile.viewModel.userOutput,
    builder: (context, snapshot) {
      var data = snapshot.data ;

      return data != null ?  Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appBarProfileColor,
            elevation: 0.0,
            centerTitle: true,
            title: Text( data.username.toString() ,/*style: const TextStyle(color: Colors.black ,),*/),
          ),
          body:SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(AppIcons.background1, width: double.infinity,fit: BoxFit.fill,height: 195,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        //color: AppColor.appBarProfileColor,
                        width: double.infinity,
                        height:170,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20.0,),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius:31.71,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(data.imgUrl.toString(),),
                                      onBackgroundImageError: (exception, stackTrace) => AssetImage(AppIcons.defaultImg,),
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Text(data.name.toString(),style: Theme.of(context).textTheme.bodyLarge,),
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
                                      child: Text(data.bio.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18.0 , color: Color.fromRGBO(0, 0, 0, 0.71)),overflow: TextOverflow.visible,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.message_rounded, color:  AppColor.primary[600],),
                                IconButton(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatListScreen(),));
                                }, icon: Image.asset(AppIcons.message , color: AppColor.primary,) ,),
                                const SizedBox(width: 20.0,),
                                Container(
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  width: 213,
                                  child: MaterialButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen(),));
                                  },
                                    color: AppColor.primary,
                                    child: const Text(AppStrings.edit ,style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 24.0), ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Padding(
                          padding:const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
                          child: Text('المنشورات ' , style:Theme.of(context).textTheme.bodyLarge),
                        ),
                        _postsWidget(context),
                      /*  StreamBuilder<FlowState>(
                          stream: UserProfile.viewModel.postsState.stream,
                        builder:  (context, snapshot) => snapshot.data?.getScreenWidget(context, , (){
                          UserProfile.viewModel.getPosts();
                        }) ?? Container(height:180,) ,
                        ),*/
                        const SizedBox(height: 20.0,),
                         Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
                          child: Text('الاعجابات ' , style: Theme.of(context).textTheme.bodyLarge!),
                        ),
                        _lovePosts(),
                     /*   StreamBuilder<FlowState>(
                          stream: UserProfile.viewModel.postsLoveState.stream,
                          builder:  (context, snapshot) => snapshot.data?.getScreenWidget(context, _lovePosts(), (){
                            UserProfile.viewModel.getLovePosts();
                          }) ??Container() ,
                        ),*/
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
                                  Text(data.likes!.length.toString() , style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontFamily: AppConstant.fontFamilyRoboto )),
                                    Text('الإعجابات' , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                                  const Divider(color: Colors.white,),
                                ],
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: AppConstant.followers, usersId: AppConstant.userObject!.followers!),)) ;
                                },
                                child: Column(
                                  children: [
                                    Text(data.followers!.length.toString(), style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontFamily: AppConstant.fontFamilyRoboto )),
                                     Text('المتابعون' , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                                    const Divider(color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: AppConstant.following, usersId: AppConstant.userObject!.following!),)) ;
                                },
                                child: Column(
                                  children: [
                                    Text(data.following!.length.toString() , style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontFamily: AppConstant.fontFamilyRoboto )),
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
                )
              ],
            ),
          )
      ) :     const Scaffold(body:Center(child:CircularProgressIndicator()),);
    }
  );

  _postsWidget(context)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewMyPostsScreen() ,));
    },
    child: StreamBuilder<List<PostModel>?>(
      stream: UserProfile.viewModel.postsOutput,
      builder: (context, snapshot) {
        var posts = snapshot.data;
        return posts == null ? Lottie.asset(AppLotte.empty,height: 180 , width: 180) : Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration:const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0) , bottomLeft: Radius.circular(30.0))),
            height: 180.0,
            child: RefreshIndicator(
              onRefresh: () {
                return UserProfile.viewModel.getPosts();
              },
              child: GridView.builder(itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.grey , width: 0.5)
                      ),
                      child: Image.network(posts[index].postImg!,width: 109 , height:  89.19,fit: BoxFit.fill, )),
                );
              }, itemCount:posts.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ) ,
                physics:const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        );
      }
    ),
  );
  _lovePosts()=> StreamBuilder<List<PostModel>?>(
    stream: UserProfile.viewModel.lovePostsOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data==null ? Container()  :  Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: SizedBox(
          height: 150.0,
          child: ListView.separated(itemBuilder: (context, index) {
            return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),),
                child: Image.network(data[index].postImg!,width: 140 , height:  143,fit: BoxFit.fill, ));
          }, separatorBuilder: (context, index) =>const SizedBox(width:10.0,) , itemCount:data.length ,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,),
        ),
      );
    }
  );
}
