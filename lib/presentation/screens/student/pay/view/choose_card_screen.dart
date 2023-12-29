import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/main_screen/view_model/main_view_model.dart';
import 'package:rababa/presentation/screens/student/pay/view_model/pay_view_model.dart';
import 'package:rababa/presentation/screens/student/show_added_card_screen/view/show_added_card_screen.dart';
import 'package:rababa/presentation/screens/student/show_all_teacher/view/show_all_teachers.dart';
import 'package:rababa/presentation/screens/student/teacher_profile_screen/view/teacher_profile_view.dart';

import '../../../../../app/di.dart';
import '../../../../../app/end_points/constant.dart';
import '../../../../../data/model/card_model.dart';
import '../../show_added_card_screen/view_model/show_added_card_view_model.dart';

class ChooseCardScreen extends StatefulWidget {
    ChooseCardScreen({Key? key, required this.orderObject}) : super(key: key);
  OrderObject orderObject;
  @override
  State<ChooseCardScreen> createState() => _ChooseCardScreenState();
}

class _ChooseCardScreenState extends State<ChooseCardScreen> {
  final PayViewModel _viewModel = instance();
  final ShowAddCardViewModel _cardsViewModel  = instance();
  String? currentCard ;
  @override
  void initState() {
    super.initState();
    _viewModel.orderObject =  _viewModel.orderObject.copyWith(
      date: widget.orderObject.date ,
      status: widget.orderObject.status ,
      teacherId:   widget.orderObject.teacherId ,
      machine:   widget.orderObject.machine ,
      studentId:   widget.orderObject.studentId ,
      total:   widget.orderObject.total ,
      studentName:  widget.orderObject.studentName ,
      orderNumber:  widget.orderObject.orderNumber ,
      teacherName:   widget.orderObject.teacherName ,
    ) ;
    _viewModel.start();
    _cardsViewModel.getAllCardsWithOutState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(), (){
            if(snapshot.data?.getStateRendererType() == StateRendererType.fullScreenSuccessState)
              {
                Navigator.of(context).pop();
              AppConstant.pageController.animateToPage(3, duration: const Duration(milliseconds: 500), curve: Curves.easeInSine);
              }
          })??Container(),
        ),
      ),
    );

  }
  _scaffold()=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          const Text(AppStrings.chooseCard, style: TextStyle(fontSize: 24.0),)  ,
          const SizedBox(width:20.0,) ,
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0)
            ),
            width: MediaQuery.of(context).size.width-135.0,
            child: StreamBuilder<List<CardModel>>(
              stream: _cardsViewModel.outputCards,
              builder: (context, snapshot) {
                return snapshot.data == null?  Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ليس لديك اي بطاقات . ') ,
                    TextButton(onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShowAddCardScreen(),));
                    }, child: const Text('اضافة'))
                  ],
                ),):  DropdownButton<String>(items:
                  snapshot.data!.map((e) =>  DropdownMenuItem<String>(value: e.cardNumber,
                    onTap: () {
                      currentCard = e.cardNumber ;
                      setState(() {

                      });
                    },
                    child:Text(e.cardNumber , textAlign: TextAlign.center) ,)).toList(),
                  isExpanded: true,
                  value:currentCard??snapshot.data![0].cardNumber,

                  underline: Container(),
                  onChanged: (value) {
                  },
                );
              }
            ),
          )
        ],
      ),
      const SizedBox(height: 20.0,),
      Row(
        children: [
          const Text(AppStrings.enterCCV, style: TextStyle(fontSize: 24.0),)  ,
          const SizedBox(width:20.0,) ,
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0)
            ),
            width: MediaQuery.of(context).size.width-135.0,
            child: TextFormField(
              autovalidateMode:AutovalidateMode.onUserInteraction ,
              validator: (value) {
                return value!.length<3 ? 'خطاء في cvv' :  null ;
              },

              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ] ,
              maxLength:3 ,
              onChanged: (value) {
                _viewModel.cvv = value;
              },
              keyboardType:TextInputType.number ,
              decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)) ,
                focusedErrorBorder:   OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)) ,
                errorBorder:   OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)) ,
              ),
            ),
          ) ,

        ],
      ),
      const SizedBox(height:100.0,),
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0)
        ),
        width: double.infinity,
        child: MaterialButton(onPressed: (){
          print(_viewModel.orderObject.date) ;

          _viewModel.pay();
          /*   showDialog(context: context,
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                CircleAvatar(radius: 50.0 , child: Icon(Icons.check, size: 50,),),
              ],
            ),
          );*/
        },
          color: AppColor.primary[600],
          child: const Text(AppStrings.ok ,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 38.0), ),),
      )
    ],
  );
}
