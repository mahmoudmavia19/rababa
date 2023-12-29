import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/chat/view/chat_list_screen.dart';
import 'package:rababa/presentation/screens/student/show_users/view/show_users.dart';
import 'package:rababa/presentation/screens/teacher/change_price/view/change_price_screen.dart';
import 'package:rababa/presentation/screens/teacher/show_certificates/show_certificates_screen.dart';
import 'package:rababa/presentation/screens/teacher/teacher_certificate/view/edith_certificate.dart';
import 'package:rababa/presentation/screens/teacher/teacher_setting/view/teacher_setting_screen.dart';
import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../../data/model/rate_model.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../student/view_my_posts/view/view_my_posts.dart';
import '../view_model/teacher_prfile_view_model.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);
  static final TeacherMainProfileViewModel viewModel = instance() ;

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {

  bool showRated = false ;
  _bind() {
    TeacherProfile.viewModel.start();
    TeacherProfile.viewModel.getRate();
  }

  @override
  void initState() {
    _bind();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: TeacherProfile.viewModel.outputState ,
      builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(context),(){})??const Scaffold(body:Center(child:CircularProgressIndicator()),),
    );
  }
  _scaffold(context)=>StreamBuilder<UserModel?>(
    stream: TeacherProfile.viewModel.userOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data==null?    const Scaffold(body:Center(child:CircularProgressIndicator()))  :
      Scaffold(
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
                                const SizedBox(width: 20.0,),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius:31.71,
                                      backgroundColor: Colors.white,
                                      backgroundImage:data.imgUrl!=null ?  NetworkImage(data.imgUrl.toString(),) as ImageProvider : AssetImage(AppIcons.defaultImg),
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Text(data.name.toString(),style: Theme.of(context).textTheme.bodyLarge,),
                                    const SizedBox(height: 10.0,),
                                    StreamBuilder<List<RateModel>>(
                                        stream: TeacherProfile.viewModel.ratesStream.stream,
                                        builder: (context, snapshot) {
                                          return RatingBar(
                                            initialRating: TeacherProfile.viewModel.rate??0.0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize:18.0 ,
                                            ratingWidget: RatingWidget(
                                              full: const Icon(Icons.star,color: AppColor.starColor,),
                                              half: const Icon(Icons.star_half_outlined,color: AppColor.starColor,),
                                              empty: const Icon(Icons.star,color:Colors.grey,),
                                            ),
                                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            ignoreGestures: true,
                                            onRatingUpdate: (rating) {

                                            },
                                          );
                                        }
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.2,),
                                  SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Text(data.bio.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18.0 , color: Color.fromRGBO(0, 0, 0, 0.71)),overflow: TextOverflow.visible,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatListScreen(),));
                                }, icon: Image.asset(AppIcons.message , color: AppColor.primary,) ,),
                                const SizedBox(width: 20.0,),
                                Container(
                                  height: 21.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  width: 213,
                                  child: MaterialButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSettingScreen(),));
                                  },
                                    color: AppColor.primary,
                                    child: const Text(AppStrings.edit ,style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0), ),),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
                            child: Text('المؤهلات ' , style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              height: 150.0,
                              child:AppConstant.userObject!.certificates==null || AppConstant.userObject!.certificates==[] ? Container(
                                padding: const EdgeInsets.all(20.0) ,
                                child: Row(
                                  children: [
                                    Text('ليس لديك اي مؤهلات , '),
                                    TextButton(onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditCertificate(),));
                                    }, child: Text('اضافة'),)
                                  ],
                                ),
                              ) : InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCertificatesScreen(user:
                                  UserModel(AppConstant.userObject!.name,
                                      AppConstant.userObject!.username,AppConstant.userObject!. email,
                                      AppConstant.userObject!.bio, AppConstant.userObject!.uid,
                                      AppConstant.userObject!.likes,AppConstant.userObject!. followers,
                                      AppConstant.userObject!.following,AppConstant.userObject!.userType ,
                                      imgUrl: AppConstant.userObject!.imgUrl,
                                      musicInstrument:AppConstant.userObject!.musicInstrument ,
                                      blockers: AppConstant.userObject!.blockers ,
                                      certificate:  AppConstant.userObject!.certificate ,
                                      isBlocked: AppConstant.userObject!.isBlocked,
                                      isAccepted: AppConstant.userObject!.isAccepted,
                                      country: AppConstant.userObject!.country,
                                      certificates: AppConstant.userObject!.certificates,
                                      price:  AppConstant.userObject!.price,
                                      rate:   AppConstant.userObject!.rate)),)) ;
                                },
                                child: ListView.separated(itemBuilder: (context, index) {
                                  return  Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),),
                                      child: Image.network(AppConstant.userObject!.certificates![index],width: 140 , height:  143,fit: BoxFit.fill, ));
                                }, separatorBuilder: (context, index) =>const SizedBox(width:10.0,) , itemCount:AppConstant.userObject!.certificates!.length,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,),
                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
                            child: Text('المنشورات ' , style: Theme.of(context).textTheme.bodyLarge!),
                          ),
                        /*  StreamBuilder<FlowState>(
                            stream: TeacherProfile.viewModel.postsState.stream,
                            builder:  (context, snapshot) => snapshot.data?.getScreenWidget(context,, (){
                              TeacherProfile.viewModel.getPosts();
                            }) ?? Container(height:180,) ,
                          ),*/
                          _postsWidget(context) ,
                          const SizedBox(height: 20.0,),
                          Padding(
                            padding:const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
                            child: Text('الاعجابات ' , style: Theme.of(context).textTheme.bodyLarge!),
                          ),
                         /* StreamBuilder<FlowState>(
                            stream: TeacherProfile.viewModel.postsLoveState.stream,
                            builder:  (context, snapshot) => snapshot.data?.getScreenWidget(context, (){
                              TeacherProfile.viewModel.getLovePosts();
                            }) ??Container() ,
                          ),*/
                          _lovePosts(),
                          const SizedBox(height: 20.0,),
                          Center(
                            child: Container(
                              height: 24.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              width: 186,
                              child: MaterialButton(onPressed: (){
                                setState(() {
                                  showRated = !showRated  ;
                                });
                              },
                                color: AppColor.primary,
                                child: const Text('التقييمات',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20.0), ),),
                            ),
                          ),
                          if(showRated)
                            StreamBuilder<List<RateModel>>(
                                stream: TeacherProfile.viewModel.ratesStream.stream,
                                builder: (context, snapshot) {
                                  var data = snapshot.data;
                                  return data==null ?Container() :  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => ListTile(
                                      trailing:    Text(DateFormat.jm(AppConstant.ar).format(data[index].date)),
                                      subtitle:   Text(data[index].comment),
                                      title:  RatingBar.builder(
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        initialRating: data[index].rate,
                                        ignoreGestures: true,
                                        glowColor: Colors.amber,
                                        itemBuilder: (context, index) => const Icon(Icons.star , color: Colors.amber),
                                        onRatingUpdate: (value) {

                                        },) ,
                                    ),itemCount: data.length,);
                                }
                            )
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
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePriceScreen()));
                                  },
                                  child: Column(
                                    children:   [
                                      Text(data.price??'0.0SR' , style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontSize:14.0  ,fontFamily: AppConstant.fontFamilyRoboto )),
                                      Text('السعر' , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
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
            ) ,
          )
      );
    }
  );

  _postsWidget(context)=>InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ViewMyPostsScreen() ,));
    },
    child: StreamBuilder<List<PostModel>?>(
        stream: TeacherProfile.viewModel.postsOutput,
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
                  return TeacherProfile.viewModel.getPosts();
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
      stream: TeacherProfile.viewModel.lovePostsOutput,
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





