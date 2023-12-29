import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/screens/student/live/view/rateing_screen.dart';
import 'package:rababa/presentation/screens/student/live/view_model/rate_view_model.dart';

import '../../../resources/color_manager.dart';
import '../chat/view/chat_screen.dart';
import 'chat_desgin.dart';

class LiveScreen extends StatefulWidget {
    LiveScreen({Key? key, required this.order}) : super(key: key);
  OrderModel? order;

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

  RateViewModel rateViewModel = instance();

  @override
  void initState() {
    rateViewModel.start() ;
    rateViewModel.getTeacher(AppConstant.userType==UserType.teach?widget.order!.studentId!:widget.order!.teacherId!);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: rateViewModel.outputState,
      builder: (context, snapshot) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: snapshot.data?.getScreenWidget(context, _scaffold(), (){
            Navigator.pop(context);
          })??_scaffold()

        );
      }
    );
  }

  _scaffold()=>Scaffold(
    appBar: AppBar(
      elevation: 0.0,
      toolbarHeight: 70.0,
      leading: IconButton(icon: const Icon(Icons.arrow_back_ios),onPressed: () {
        Navigator.pop(context);
      },),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppIcons.sound),
          const Spacer(),
          Image.asset(AppIcons.logo),
          const Spacer(),
          InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) => Dialog(
                  alignment: Alignment.topCenter,
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 100.0,),
                      Align(
                          alignment:Alignment.topRight,
                          child: IconButton(onPressed: (){
                            Navigator.pop(context);
                            if(AppConstant.userType == UserType.teach)
                            {
                              Navigator.pop(context);
                            }else
                            {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) =>RatingScreen(order: widget.order),)) ;
                            }
                          }, icon: Image.asset(AppIcons.cancel,color: Colors.black,))),
                      const SizedBox(height: 100.0,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                            color: AppColor.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('تم انتهاء الدرس',style: Theme.of(context).textTheme.bodyLarge,),
                            const SizedBox(height: 10.0,),
                            Image.asset(AppIcons.registerTopImage , height: 100,width: 300,fit: BoxFit.fill,)
                          ],
                        ),
                      )
                    ],
                  ),
                ));
              },
              child: Image.asset(AppIcons.cancel)),
        ],
      ),
    ),

    body: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(child: Image.asset(AppIcons.person2, fit: BoxFit.fill,width: double.infinity,)),
          const SizedBox(height: 2.0,),
          Expanded(child: Image.asset(AppIcons.person1, fit: BoxFit.fill,width: double.infinity)),
        ],
      ),
    ),
    bottomSheet: SizedBox(
      height: 70.0,
      child: Row(
        children: [
          Expanded(child: Image.asset(AppIcons.videocall,)),
          Expanded(child: Image.asset(AppIcons.speaker,)),
          Expanded(child: StreamBuilder<UserModel?>(
              stream: rateViewModel.teacherCon.stream,
              builder: (context, snapshot) {
                return InkWell(child: Image.asset(AppIcons.messageicon),
                    onTap: snapshot.data!=null  ? () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatScreen(userModel:snapshot.data!)));}:null);
              }
          )),
        ],
      ),
    ),
  );
}
