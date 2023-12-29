import 'package:flutter/material.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/teacher_item_view.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/show_all_teacher/view_model/show_teacher_view_model.dart';
import 'package:rababa/presentation/screens/student/teacher_profile_screen/view/teacher_profile_view.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../../app/di.dart';
import '../../../../../data/model/user_model.dart';
import '../../../../common/component/music_machine_popup.dart';
import '../../compare_teachers.dart';

class ShowAllTeachers extends StatefulWidget {
  const ShowAllTeachers({Key? key}) : super(key: key);

  @override
  State<ShowAllTeachers> createState() => _ShowAllTeachersState();
}

class _ShowAllTeachersState extends State<ShowAllTeachers> {
  final ShowAllTeachersViewModel _viewModel = instance();
  String _selection = AppIcons.icon1;
  bool compare = false ;
  List<UserModel> user = [] ;
  @override
  void initState() {
    _viewModel.start() ;
    user = [] ;
    _viewModel.compareErrorStream.stream.listen((event) {
    if(event){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showBottomSheet(context: context, builder: (context) => CompareTeachers(users: user,));
      });
    }
    });
     super.initState();
  }

  @override
  void dispose() {


    super.dispose();

  }
  @override
  void didChangeDependencies() {
     super.didChangeDependencies();
    print('close') ;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90.0,
        backgroundColor: AppColor.scaffoldBackgroundColor,
        title:Column(
          children: [
            const SizedBox(height: 10.0,),
            Row(
              children: [
                IconButton(onPressed: (){
                  setState(() {
                    compare = !compare ;
                  });
                  if(compare){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                         setState(() {
                           compare = false ;
                        });
                       _viewModel.compareErrorHandle(user) ;

                      },
                      child: Row(children: const [
                        Icon(Icons.arrow_back_ios,color: Colors.white,),
                        Text(AppStrings.compare)
                      ],),
                    ), backgroundColor: AppColor.cardColor,duration: const Duration(days: 365),));
                  }
                  else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                }, icon:Icon(Icons.check_box_outlined , size: 30.0,color:compare ?AppColor.primary[600] : Colors.grey,)),
                const SizedBox(width: 20.0,),
                Expanded(
                  child: StreamBuilder<List<UserModel>>(
                    stream: _viewModel.teacherOutput,
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF68696C).withOpacity(0.17),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        height: 35.0,
                        child: SearchField<UserModel>(

                          hint: AppStrings.teacherSearch,

                          onSuggestionTap: (p0) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherProfileView(user: p0.item!),)) ;
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
                          /*style: const TextStyle(fontSize: 18.0,height: 2),
                          decoration:  InputDecoration(
                            hintStyle:const TextStyle(fontSize: 18.0,color: Color(0xFFC4C4C4),height: 2.5),
                            prefixIcon: const Icon(Icons.search_sharp,color: Color(0xFFAFADAD),),
                            hintText: AppStrings.teacherSearch,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                            focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                          ),*/
                        ),
                      );
                    }
                  ),
                ),
                const SizedBox(width: 10.0,),
                PopupMenuButton<String>(itemBuilder: (context) => [
                  PopupMenuItem<String>(padding: EdgeInsets.zero ,value: AppConstant.qanun,child: Center(child: Image.asset(AppIcons.icon1,width: 30.0,fit: BoxFit.fill,)),),
                  PopupMenuItem<String>(padding: EdgeInsets.zero ,value: AppConstant.nay,child: Center(child: Image.asset(AppIcons.icon2,width: 30.0,fit: BoxFit.fill,)),),
                  PopupMenuItem<String>(padding: EdgeInsets.zero ,value: AppConstant.oud,child: Center(child: Image.asset(AppIcons.icon3,width: 30.0,fit: BoxFit.fill,)),),
                  PopupMenuItem<String>(padding: EdgeInsets.zero ,value: AppConstant.kaman,child: Center(child: Image.asset(AppIcons.icon4,width: 30.0,fit: BoxFit.fill,)),),
                ],
                  onSelected: (value) {
                    switch(value) {
                      case AppConstant.qanun:
                        _selection = AppIcons.icon1 ;
                        break;
                      case AppConstant.nay:
                        _selection = AppIcons.icon2 ;
                        break;
                      case AppConstant.oud:
                        _selection = AppIcons.icon3 ;
                        break;
                      case AppConstant.kaman:
                        _selection = AppIcons.icon4 ;
                        break;
                    }
                    user = [] ;
                    _viewModel.teacherType = value ;
                    _viewModel.getAllTeacher();
                    setState((){});
                    print(value);
                  },
                  position: PopupMenuPosition.under,
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(50.0)), padding: EdgeInsets.zero ,
                  icon:Image.asset(_selection,width: 40.0,fit: BoxFit.fill), color: AppColor.scaffoldBackgroundColor, )
              ],
            ),
            Text(AppStrings.teachers , style:Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey)),
          ],
        ),
      ),
      body:StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>snapshot.data?.getScreenWidget(context, _widgets(),(){})??Container() ,)

    );
  }

  _widgets()=>StreamBuilder<List<UserModel>>(
      stream: _viewModel.teacherOutput,
      builder: (context, snapshot) {
        var data = snapshot.data ;
        return data==null ?  Container():
        ListView.builder(itemBuilder: (context, index) =>  TeacherItemView(
          select: compare, user:data[index],
          action: (value) {
            if(value) {
                user.add(data[index]);
              }
            else {
              user.removeWhere((element) => element== data[index]);
            }
            print(user);
          },
        ),itemCount:data.length,);
      }
  );
}
