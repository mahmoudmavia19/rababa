import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/screens/student/another_user_screen/view/anthor_student_profile.dart';
import 'package:rababa/presentation/screens/student/show_users/view_model/show_users_view_model.dart';
import '../../resources/strings_manager.dart';

class ShowBlockUsers extends StatefulWidget {
  ShowBlockUsers({Key? key}) : super(key: key);
  String title  = AppStrings.blockers;

  @override
  State<ShowBlockUsers> createState() => _ShowBlockUserstate();
}

class _ShowBlockUserstate extends State<ShowBlockUsers> {

  final ShowUsersViewModel _viewModel = instance() ;
  @override
  void initState() {
    _viewModel.getListOfUsers(AppConstant.userObject!.blockers??[]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text(widget.title,),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(), (){
              _viewModel.getListOfUsers(AppConstant.userObject!.blockers!);
            })??Container(),
          )
      ),
    );
  }

  _scaffold()=>StreamBuilder<List<UserModel>>(
      stream: _viewModel.usersOutput,
      builder: (context, snapshot) {
        var data = snapshot.data ;

        return data == null ?Container() :  RefreshIndicator(
          onRefresh: () async{
            print("refresh") ;
            print("is blocked ${AppConstant.userObject!.blockers!}") ;
            _viewModel.getListOfUsers(AppConstant.userObject!.blockers!);
          },
          child: ListView.builder(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>   AnotherStudentProfile(
                  user: data[index], posts: const [],),));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius:30.0 ,
                      backgroundImage:data[index].imgUrl ==null ? AssetImage(AppIcons.defaultImg) as ImageProvider : NetworkImage(data[index].imgUrl!) ,
                    ),
                    const SizedBox(width: 10.0,) ,
                    Text(data[index].name??'', style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
            ),
            itemCount: data.length,
          ),
        );
      }
  );
}
