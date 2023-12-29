import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:rababa/app/di.dart';
 import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/setting_item.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/authentication/reset_password_screen/view/reset_password_screen.dart';
import 'package:rababa/presentation/screens/student/about_screen.dart';
import 'package:rababa/presentation/screens/student/setting_screen/view_model/setting_view_model.dart';
import 'package:rababa/presentation/screens/student/show_added_card_screen/view/show_added_card_screen.dart';
 import 'package:rababa/presentation/screens/student/add_suggestion_screen/view/suggestions_screen.dart';
import 'package:rababa/presentation/screens/student/update_profile_screen/view/update_profile_screen.dart';
import '../../../../resources/color_manager.dart';
import '../../profile_screen/view_model/student_profile_view_model.dart';
import '../../show_block_users.dart';

class SettingScreen extends StatefulWidget {
    const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
    final SettingViewModel _viewModel= SettingViewModel();
    final StudentProfileViewModel _profileViewModel = instance();

    @override
  void initState() {
      _profileViewModel.getProfile();
    super.initState();
  }

  @override
  void dispose() {
   // _viewModel.dispose();
    print('did change');
    super.dispose();
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
                              /*  const Spacer(),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UpdateProfileScreen(),));
                }),
                SettingItem(title: AppStrings.blockers, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowBlockUsers()));
                }),
                SettingItem(title: AppStrings.uploadSuggestion, onTap: (){
                  initAddSuggestionModule();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SuggestionsScreen(),));
                }),
                SettingItem(title: AppStrings.cardAccount, onTap: (){
                  initShowCreditCardModule();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   const ShowAddCardScreen(),));
                }),
                SettingItem(title: AppStrings.changePassword, onTap: (){
                  initResetPasswordModule ();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),));
                }),
                Divider(color: AppColor.primary[600],thickness: 2.0, endIndent: 30.0,indent: 30.0, ) ,
                SettingItem(title: AppStrings.whatUs, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen(),));
                } ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: StreamBuilder<FlowState>(
                    stream: _viewModel.outputState,
                    builder: (context, snapshot) {
                      return snapshot.data?.getScreenWidget(context, _buttonLogout(), (){})??_buttonLogout();
                    }
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
