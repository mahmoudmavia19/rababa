import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/courses_items/current_courses.dart';
import '../../../../app/end_points/constant.dart';
import '../../../../data/model/order_model.dart';

class UpcomingCourses extends StatelessWidget {
  UpcomingCourses({Key? key, required this.items}) : super(key: key);
  List<OrderModel> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text('القادمة : ', style: TextStyle(color: Colors.grey,
                fontSize: 36.0,
                fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length, itemBuilder: (context, index) =>
                Card(
                  color: AppColor.courseCardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('اسم الدورة : ', style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(items[index].machine ?? '',
                                      style: const TextStyle(fontSize: 24.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('التاريخ : ', style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat.yMd(AppConstant.ar).format(items[index].date!),
                                      style: const TextStyle(fontSize: 24.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('الوقت : ', style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(DateFormat.jm(AppConstant.ar).format(items[index].date!),
                                      style: const TextStyle(fontSize: 24.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children:  [
                                  const  Text('الحالة : ', style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                                  Text(items[index].status??'', style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                         SizedBox(
                           child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.amber, radius: 5.0,),
                              const SizedBox(height: 10.0,),
                              _machineWidget(items[index].machine ?? ''),
                              const SizedBox(height: 10.0,),
                              Text('${items[index].teacherName}' ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 24.0,
                                      fontWeight: FontWeight.bold)),
                            ],),
                        )
                      ],
                    ),
                  ),
                ),

            ),
          )
        ],
      ),
    );
  }

  _machineWidget(String machine) =>
      CircleAvatar(backgroundImage: AssetImage(machine.getMachine()),);
}
