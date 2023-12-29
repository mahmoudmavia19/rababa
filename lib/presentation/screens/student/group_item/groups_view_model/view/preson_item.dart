import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/screens/student/group_item/groups_view_model/view_model/group_view_model.dart';
import 'package:rababa/presentation/screens/student/view_user_posts/view/view_users_posts_screen.dart';


class PersonItem extends StatefulWidget {
  const PersonItem({Key? key}) : super(key: key);

  @override
  State<PersonItem> createState() => _PersonItemState();
}

class _PersonItemState extends State<PersonItem> {
  final GroupViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0,),
        Expanded(
            child: RefreshIndicator(
              onRefresh: () => _viewModel.getAllUsers() ,
              child: StreamBuilder<FlowState>(
                stream: _viewModel.outputState,
                builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidget(), (){})??Container(),
              ),
            )
        )
      ],
    );
  }
  _scaffoldWidget()=>StreamBuilder<List<UserModel>>(
    stream: _viewModel.usersOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data == null ? Container(): GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: data.length,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3, crossAxisSpacing:20.0, mainAxisSpacing: 10.0),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            showBottomSheet(context: context,
              builder: (context) => ViewUserPostsScreen(user: data[index],),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.black,
                borderRadius: BorderRadius.circular(15.0)
            ),
            child:data[index].imgUrl !=null ? Image.network(data[index].imgUrl! , fit: BoxFit.cover,)  : Image.asset(AppIcons.defaultImg),
          ),
        ),);
    }
  );
}
