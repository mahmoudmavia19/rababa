import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/app/extentions.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import '../../../../../data/model/order_model.dart';
import '../../../student/chat/view/chat_screen.dart';
import '../../../student/live/live_screen.dart';
import '../view_model/courses_dates_view_model.dart';

class CourseDatesScreen extends StatefulWidget {
    const CourseDatesScreen({Key? key}) : super(key: key);

  @override
  State<CourseDatesScreen> createState() => _CourseDatesScreenState();
}

class _CourseDatesScreenState extends State<CourseDatesScreen> {
    final CoursesDatesViewModel _viewModel = instance();
    DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
    @override
  void initState() {
    _viewModel.getOrdersDay(selectedDate);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0,) ,
              Text('التقويم', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 48)) ,
              const SizedBox(height: 20.0,) ,
               Directionality(
                  textDirection: TextDirection.ltr,
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        firstDate: DateUtils.dateOnly(DateTime.now()),
                        currentDate: selectedDate,
                        calendarType: CalendarDatePicker2Type.single,
                        controlsTextStyle: Theme.of(context).textTheme.titleMedium,
                        dayBuilder: ({required date, decoration, isDisabled, isSelected, isToday, textStyle}) {
                          return isSelected! || isToday!? CircleAvatar(
                            backgroundColor: AppColor.datePickerColor,
                            child: Text(date.day.toString(),style: const TextStyle(color: Colors.white),),
                          ) :  CircleAvatar(
                            backgroundColor: Colors.white,

                            child: Text(date.day.toString()),
                          ) ;
                        },
                      ),
                      onValueChanged: (dates){
                        _viewModel.getOrdersDay(dates.last!) ;
                        selectedDate = dates.last! ;
                        setState(() {

                        });
                      },
                      value: [],
                    ),
                  ),
                ),
          const SizedBox(height: 20.0,),
              StreamBuilder<FlowState>(
                stream: _viewModel.outputState,
                builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(), (){
                  _viewModel.getOrdersDay(selectedDate) ;
                })??Container(),
              ) ,
            ],
          ),
        ),
      ),
    );
  }
  _scaffold()=>StreamBuilder<List<OrderModel>>(
    stream: _viewModel.ordersOutput,
      builder: (context, snapshot) {
      var data = snapshot.data;
        return  data==null ? Container() :ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _item(data[index],index);

        },);
      },) ;
  _item(OrderModel orderModel,index)=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: AppColor.dateCardColor ,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('من الساعة ${intl.DateFormat.jm(AppConstant.ar).format(orderModel.date!)} - ${intl.DateFormat.jm(AppConstant.ar).format(orderModel.date!.add(const Duration(hours: 1)))} ', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                        Row(
                          children: [
                            Text('اسم الطالب: ${orderModel.studentName}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                            const SizedBox(width: 20.0,),
                            Text('${orderModel.machine}', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                          ],
                        )
                      ],
                    ) ,
                    const Spacer(),
                    Image.asset(AppIcons.teacherIcon, width:30.0,height: 38.0,color:AppColor.primary[600],)
                  ],
                )
            ),
            const SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.dateCardColor,
                  radius: 25.0,
                  child: IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ChatScreen(userModel: _viewModel.userOfOrders[index],),));
                  },icon: Image.asset(AppIcons.messageicon2,color: AppColor.datePickerColor,height: 20.0, width: 20.0,) , ),
                ),
                const SizedBox(width: 20.0,),
                CircleAvatar(
                  backgroundColor: AppColor.dateCardColor,
                  radius: 25.0,
                  child: IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>   LiveScreen(order: orderModel),));
                  }, icon: Image.asset(AppIcons.videoicon,color: AppColor.datePickerColor,) , ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
