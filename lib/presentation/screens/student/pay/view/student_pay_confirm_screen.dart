import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/pay/view/choose_card_screen.dart';
import 'package:rababa/presentation/screens/student/pay/view_model/pay_view_model.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../app/end_points/constant.dart';
import '../../../../common/state_renderer/state_renderer.dart';

class StudentPayConfirmScreen extends StatefulWidget {
    StudentPayConfirmScreen({Key? key , required this.teacher }) : super(key: key);
    UserModel teacher;

  @override
  State<StudentPayConfirmScreen> createState() => _StudentPayConfirmScreenState();
}

class _StudentPayConfirmScreenState extends State<StudentPayConfirmScreen> {

  bool iniBool = true ;
  int count = 0 ;
  var monthCon = FixedExtentScrollController();
  final PayViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start();
    _viewModel.setTeacher(widget.teacher) ;
    _viewModel.setTotal(widget.teacher.price) ;
    _viewModel.setDate(DateTime.now()) ;
    _viewModel.setMachine(widget.teacher.musicInstrument!);
    super.initState();
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldContent(), (){
          if(snapshot.data?.getStateRendererType() == StateRendererType.fullScreenSuccessState)
          {
            Navigator.of(context).pop();
            AppConstant.pageController.animateToPage(3, duration: const Duration(milliseconds: 500), curve: Curves.easeInSine);
          }
        })??_scaffoldContent(),
      )
    );
  }

  _scaffoldContent()=>SingleChildScrollView(
    padding:  const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 450,
          child: StreamBuilder<DateTime>(
              stream: _viewModel.datePicker.stream,
              builder: (context, snapshot) {
                return
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SfDateRangePicker(
                        initialDisplayDate:DateTime.now(),
                        enablePastDates: false,
                        selectionMode: DateRangePickerSelectionMode.single,
                        onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                          print(dateRangePickerSelectionChangedArgs.value);
                          showTimePicker(context: context, initialTime: TimeOfDay.now()) .then((value){
                            DateTime date = dateRangePickerSelectionChangedArgs.value ;
                            date = date.copyWith(hour: value!.hour ,minute: value.minute );
                            _viewModel.setDate(date) ;
                            print(date) ;
                          });

                        },
                      ),
                    ),
                  ) ;
              }
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0 , vertical: 10.0),
          decoration: BoxDecoration(
            color: AppColor.salaryConColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children:  [
              const Text('السعر الإجمالي' , style: TextStyle(color: Colors.black , fontSize: 24.0),) ,
              const Spacer(),
              Text(widget.teacher.price??'0.0 SR',style: const TextStyle(color: Colors.black , fontSize: 24.0),) ,
            ],
          ),
        ),
        const SizedBox(height: 20.0) ,
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: double.infinity,
          child: MaterialButton(onPressed: (){
            print("apple pay") ;
            _viewModel.cvv = "562" ;
            _viewModel.pay() ;
          } ,
            color: Colors.black,
            height: 45.0,
            child:   const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.apple, color: Colors.white,size: 31.0,),
                SizedBox(width: 10.0,),
                Text('Pay', style: TextStyle(color: Colors.white , fontSize: 32.0 ),),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0) ,
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColor.salaryConColor)
          ),
          width: double.infinity,
          child: MaterialButton(onPressed: (){
            initShowCreditCardModule();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>   ChooseCardScreen(orderObject: _viewModel.orderObject),));
          } ,
            height: 45.0,
            child: const  Text('credit card', style: TextStyle(color: Colors.black, fontSize: 32.0 ),),
          ),
        )
      ],
    ),
  );
}
