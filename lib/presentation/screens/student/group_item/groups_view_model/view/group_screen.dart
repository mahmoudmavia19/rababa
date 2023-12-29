import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/screens/student/another_user_screen/view/anthor_student_profile.dart';
import 'package:rababa/presentation/screens/student/group_item/groups_view_model/view/preson_item.dart';
import 'package:rababa/presentation/screens/student/group_item/shops_view_model/view/shops_item.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../../../app/di.dart';
import '../../../../../../data/model/user_model.dart';
import '../../../../../resources/assets_manager.dart';
import '../../../../../resources/strings_manager.dart';
import '../../../teacher_profile_screen/view/teacher_profile_view.dart';
import '../view_model/group_view_model.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GroupViewModel _viewModel = instance();
  final TextEditingController _controller = TextEditingController() ;
/*
  bool isOPen = true ;
    bool keyboardIsOpen = false ;
*/
  final FocusNode _focus = FocusNode() ;
  @override
  void initState() {
    _viewModel.start();

      super.initState();
/*
      WidgetsBinding.instance.addObserver(this) ;
*/
  }
  @override
  void dispose() {
    print('end grou sp') ;
/*
    WidgetsBinding.instance.removeObserver(this) ;
*/
    _focus.dispose();
    super.dispose();
  }
/*  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

 *//*     keyboardIsOpen = WidgetsBinding.instance.window.viewInsets.bottom != 0.0;
    print("_focus.unfocus() $keyboardIsOpen   ${WidgetsBinding.instance.window.viewInsets.bottom }");
  *//**//*  Future.delayed(const Duration(milliseconds: 500)).then((value){
      if(!keyboardIsOpen)
      {
        print("opend");

        _focus.unfocus() ;
      }
    }) ;*//*

  }*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('close') ;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
      onChanged: (p0) {
        if(!p0){
          _focus.unfocus();
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 50.0,
            title:  Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF68696C).withOpacity(0.17),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              height: 40.0,
              child:
              StreamBuilder<List<UserModel>>(
                  stream: _viewModel.usersOutput,
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    return Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF68696C).withOpacity(0.17),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      height: 35.0,
                      child: SearchField<UserModel>(
                        focusNode: _focus,
                        hint: AppStrings.teacherSearch,
                        controller:_controller,
                        onSuggestionTap: (p0) {
                          if(p0.item!.userType==UserType.teach.userString()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherProfileView(user: p0.item!),)) ;
                          }else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherStudentProfile(user: p0.item!, posts: []),)) ;
                          }
                        },
                        searchInputDecoration: InputDecoration(
                          hintStyle:const TextStyle(fontSize: 18.0,color: Color(0xFFC4C4C4),height: 2.5),
                          prefixIcon: const Icon(Icons.search_sharp,color: Color(0xFFAFADAD),),
                          hintText: AppStrings.teacherSearch,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                          focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                        ),
                        searchStyle:const TextStyle(fontSize: 18.0,height: 2) ,
                        suggestions: data == null ? [] :  data.map((e) => SearchFieldListItem<UserModel>(e.name! ,
                            item: e ,
                            child: Container(color: Colors.white,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius:40,
                                    backgroundColor: Colors.white,
                                    backgroundImage:e.imgUrl==null ? AssetImage(AppIcons.defaultImg) as ImageProvider:  NetworkImage(e.imgUrl!),
                                  ),
                                  Text(e.name??''),
                                ],
                              ),
                            )
                        )
                        ).toList(),
                      ),
                    );
                  }
              ),
            ),
            bottom:   TabBar(tabs:[
              Tab(child: Text('أشخاص' , style: Theme.of(context).textTheme.bodyLarge)) ,
              Tab(child: Text('متاجر', style:  Theme.of(context).textTheme.bodyLarge)) ,
            ],),
          ),
          body: const TabBarView(physics: NeverScrollableScrollPhysics(),children: [
            PersonItem(),
            ShopsItem()
          ],)
        ),
      ),
    );

  }
}
