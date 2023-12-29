import 'package:flutter/material.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/compare_teachers_item.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';


class CompareTeachers extends StatelessWidget {
    CompareTeachers({Key? key , required this.users}) : super(key: key);
  List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 100.0,elevation: 0.0,),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0 , left: 20.0 , top: 20.0),
        child:Flex(
          direction:Axis.vertical ,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) =>CompareTeachersItem(user: users[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
