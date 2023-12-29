import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/component/setting_item.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/reset_password_screen/view/reset_password_screen.dart';
import 'package:rababa/presentation/screens/student/show_block_users.dart';
import 'package:rababa/presentation/screens/student/add_suggestion_screen/view/suggestions_screen.dart';
import 'package:rababa/presentation/screens/teacher/change_price/view/change_price_screen.dart';
import 'package:rababa/presentation/screens/teacher/teacher_certificate/view/edith_certificate.dart';
import 'package:rababa/presentation/screens/teacher/teahcer_profile/view/teacher_update_profile.dart';
import 'package:rababa/presentation/screens/teacher/teahcer_profile/view_model/teacher_prfile_view_model.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../resources/color_manager.dart';
import '../../../student/about_screen.dart';


class TeacherSettingScreen extends StatefulWidget {
  const TeacherSettingScreen({Key? key}) : super(key: key);

  @override
  State<TeacherSettingScreen> createState() => _TeacherSettingScreenState();
}

class _TeacherSettingScreenState extends State<TeacherSettingScreen> {
  final TeacherMainProfileViewModel _profileViewModel = instance();

  @override
  void initState() {
    initUserPostsModule();
    _profileViewModel.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2ADD5),
        elevation: 0.0,
      ),
      backgroundColor: AppColor.scaffoldBackgroundColor2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppIcons.background2,width: double.infinity,fit: BoxFit.cover,),
                StreamBuilder<UserModel?>(
                    stream: _profileViewModel.userOutput,
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      return data == null ?Container() :Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          width: double.infinity,
                          height:150,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius:31.71,
                                    backgroundColor: Colors.white,
                                    onBackgroundImageError: (exception, stackTrace) =>AssetImage(AppIcons.defaultImg,),
                                    backgroundImage: data.imgUrl!=null ? NetworkImage(data.imgUrl!) as ImageProvider : AssetImage(AppIcons.defaultImg),
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data.name!,style: Theme.of(context).textTheme.bodyLarge,),
                                      Text(data.username!,style: Theme.of(context).textTheme.bodyLarge,),
                                    ],
                                  ),
                                 /* const Spacer(),
                                  IconButton( onPressed: () {

                                  },  icon: const Icon(Icons.arrow_forward_ios)),*/
                                  const SizedBox(width: 10.0,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
            Column(
              children: [
                SettingItem(title: AppStrings.account, onTap: ()  {
                  initUpdateProfileModule();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UpdateTeacherProfileScreen(),));
                }),
               /* SettingItem(title: AppStrings.emailSetting, onTap: (){}),*/
                SettingItem(title: AppStrings.blockers, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowBlockUsers()));
                }),
                SettingItem(title: AppStrings.uploadSuggestion, onTap: (){
                  initAddSuggestionModule();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SuggestionsScreen(),));
                }),
                SettingItem(title: AppStrings.changePassword, onTap: (){
                  initResetPasswordModule ();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),));
                }),
                SettingItem(title: AppStrings.changeCertificate, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   EditCertificate(),));
                }),
                SettingItem(title: AppStrings.changePrice, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ChangePriceScreen(),)) ;
                }),
                Divider(color: AppColor.primary[600],thickness: 2.0, endIndent: 30.0,indent: 30.0, ) ,
                SettingItem(title: AppStrings.whatUs, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen(),));

                } ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: StreamBuilder<FlowState>(
                      builder: (context, snapshot) {
                        return snapshot.data?.getScreenWidget(context, _buttonLogout(), (){})??_buttonLogout();
                      }, stream: _profileViewModel.outputState,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ) ;
  }

  _buttonLogout()=>Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0)
    ),
    width: double.infinity,
    child: MaterialButton(onPressed: (){
      unRegister();
      FirebaseAuth.instance.signOut() ;
      Phoenix.rebirth(context);
    },
      color: AppColor.primary[600],
      child: const Text(AppStrings.logout ,style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 38.0), ),),
  );
}
