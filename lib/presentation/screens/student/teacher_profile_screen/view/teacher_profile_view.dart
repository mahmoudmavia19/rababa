import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rababa/data/model/rate_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/chat/view/chat_screen.dart';
import 'package:rababa/presentation/screens/student/show_user_posts.dart';
import 'package:rababa/presentation/screens/student/show_users/view/show_users.dart';
import 'package:rababa/presentation/screens/student/pay/view/student_pay_confirm_screen.dart';
import 'package:rababa/presentation/screens/student/teacher_profile_screen/view_model/teacher_profile_view_model.dart';
import 'package:rababa/presentation/screens/student/view_user_posts/view/view_users_posts_screen.dart';
import 'package:rababa/presentation/screens/teacher/show_certificates/show_certificates_screen.dart';

import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/post_model.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../teacher/teacher_certificate/view/edith_certificate.dart';

class TeacherProfileView extends StatefulWidget {
    TeacherProfileView({Key? key , required this.user}) : super(key: key);
  UserModel user ;
  @override
  State<TeacherProfileView> createState() => _TeacherProfileViewState();
}

class _TeacherProfileViewState extends State<TeacherProfileView> {
  bool showRated = false ;
    TeacherProfileViewModel? _viewModel  ;
  @override
  void initState() {
    _viewModel = TeacherProfileViewModel(instance(),instance(),instance(),instance(), widget.user);
    _viewModel!.start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColor.appBarProfileColor,
        elevation: 0.0,
        centerTitle: true,
        title:   Text(widget.user.username??'',style: const TextStyle(color: Colors.black ,),),
        actions: [
          PopupMenuButton<String>(itemBuilder: (context) =>[
            PopupMenuItem<String>(child:   Text(_viewModel!.isBlocked? AppStrings.unblock: AppStrings.block), onTap: () {
              _viewModel!.blocking();
            },),
            /*PopupMenuItem<String>(child: const Text(AppStrings.share), onTap: () {

            },),*/
          ], icon: const Icon(Icons.more_horiz, color: Colors.black,),color: AppColor.scaffoldBackgroundColor,)
        ],
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
                                  backgroundImage: widget.user.imgUrl == null? AssetImage(AppIcons.defaultImg,) as ImageProvider : NetworkImage(widget.user.imgUrl!),
                                ),
                                const SizedBox(height: 10.0,),
                                Text(widget.user.name??'',style: Theme.of(context).textTheme.bodyLarge,),
                                const SizedBox(height: 10.0,),
                                StreamBuilder<List<RateModel>>(
                                  stream: _viewModel?.ratesStream.stream,
                                  builder: (context, snapshot) {
                                    return RatingBar(
                                      initialRating: _viewModel!.rate??0.0,
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
                            const SizedBox(width: 20.0,),
                            Column(
                              children:   [
                                //   SizedBox(height: 5.0,),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Text(widget.user.bio??'',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18.0 , color: Color.fromRGBO(0, 0, 0, 0.71)),overflow: TextOverflow.visible,),
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
        ),
      ) ,
    );
  }
  _widgets()=> Padding(
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
                child:widget.user.certificates==null || widget.user.certificates==[] ? Container() : InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCertificatesScreen(user: widget.user) ));
                    },
                  child: ListView.separated(itemBuilder: (context, index) {
                    return  Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),),
                        child: Image.network(widget.user.certificates![index],width: 140 , height:  143,fit: BoxFit.fill, ));
                  }, separatorBuilder: (context, index) =>const SizedBox(width:10.0,) , itemCount:widget.user.certificates!.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0),
              child: Text('المنشورات ' , style: Theme.of(context).textTheme.bodyLarge!),
            ),
            StreamBuilder<FlowState>(
              stream: _viewModel!.outputState,
              builder: (context, snapshot) =>snapshot.data?.getScreenWidget(context, _postWidgets(), (){})??Container() ,
            ),
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
                    showRated = !showRated ;
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
                stream: _viewModel?.ratesStream.stream,
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
        Column(
          children: [
            const SizedBox(height: 70.0,),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(25.0)
              ),
              height: 430,
              width: 89,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left:20  , right:  20.0 , bottom: 10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children:   [
                          Text(widget.user.likes!.length.toString() , style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontFamily: AppConstant.fontFamilyRoboto )),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: 'المتابعون' , usersId: widget.user.followers!),));
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowUsers(title: 'المتابعين' , usersId: widget.user.following!),));
                        },
                        child: Column(
                          children:   [
                            Text(widget.user.following!.length.toString() , style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontFamily: AppConstant.fontFamilyRoboto )),
                            Text('المتابعين' , style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                            const Divider(color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children:   [
                          Text(widget.user.price??'0.0SR', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white,fontSize:14.0  ,fontFamily: AppConstant.fontFamilyRoboto )),
                          Text('السعر' , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal)),
                          const Divider(color: Colors.white,),
                        ],
                      ),
                    ),
                    if(AppConstant.userType!=UserType.teach)
                    if((!widget.user.isBlocked!))
                    if(widget.user.isAccepted??false)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   StudentPayConfirmScreen(teacher: widget.user),));
                        },
                        child: Column(
                          children:   [
                            const Icon(Icons.date_range,color: Colors.white,size: 30.0,),
                            const SizedBox(height: 5.0,),
                            Text('حجز موعد' , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white , fontWeight: FontWeight.normal , fontSize: 22.0)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],),
  );
_postWidgets()=>StreamBuilder<List<PostModel>>(
    stream: _viewModel!.teacherPostsOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data == null ?Container() :  InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ShowUserPosts(posts: data,user: widget.user,) ,));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: SizedBox(
            height: 100.0,
            child: ListView.separated(itemBuilder: (context, index) {
              return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(11),),
                  child: Image.network(data[index].postImg!,width: 109 , height:  89.19,fit: BoxFit.fill, ));
            }, separatorBuilder: (context, index) =>const SizedBox(width:10.0,) , itemCount: data.length ,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,),
          ),
        ),
      );
    }
);
}

