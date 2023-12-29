import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/extentions.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/add_credit_card/view/add_card_screen.dart';
import 'package:rababa/presentation/screens/student/show_added_card_screen/view_model/show_added_card_view_model.dart';

class ShowAddCardScreen extends StatefulWidget {
  const ShowAddCardScreen({Key? key}) : super(key: key);

  @override
  State<ShowAddCardScreen> createState() => _ShowAddCardScreenState();
}

class _ShowAddCardScreenState extends State<ShowAddCardScreen> {

  final ShowAddCardViewModel _viewModel = instance();
  
  _bind(){
    _viewModel.start() ;
  }
  @override
  void initState() {
    _bind() ; 
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColor.scaffoldBackgroundColor2,
      appBar: AppBar(backgroundColor: AppColor.scaffoldBackgroundColor2,elevation: 0.0,),
      body: Column(
        children:   [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return  _viewModel.getAllCards();
              },
              child: StreamBuilder<FlowState>(
                stream: _viewModel.outputState ,
                builder: (context, snapshot) =>snapshot.data?.getScreenWidget(context,  _scaffoldWidgets(), (){
                  _viewModel.getAllCards() ;
                }) ??Container(),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              width: double.infinity,
              height: 40.0,
              child: MaterialButton(onPressed: (){
                initAddCreditCardModule();
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCard(),));
              },
                color: AppColor.primary[600],
                child: const Text(AppStrings.addNewCard ,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 38.0), ),),
            ),
          )
        ],
      )
    );
  }
  
  _scaffoldWidgets()=> StreamBuilder<List<CardModel>>(
    stream: _viewModel.outputCards,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data==null?Container() : ListView.separated(itemBuilder: (context, index) =>  Row(
        children: [
          _viewModel.showCardIcon(data[index].cardNumber) ,
          const SizedBox(width: 20.0,),
          Text(data[index].cardNumber.replaceRange(4, data[index].cardNumber.length, '.....'),style:const TextStyle(fontSize: 36.0 ,color: Colors.black),) ,
          const Text('تاريخ الإنتهاء. ' , style: TextStyle(fontSize: 36.0 ,color: Colors.black),) ,
          Text('${data[index].cardExYear.cardFormat()}/${data[index].cardExMonth.cardFormat()}' ,style: const TextStyle(fontSize: 36.0 ,color: Colors.black), ) ,
        ],
      ),
          padding: const EdgeInsets.all(20.0),
          separatorBuilder:(context, index) => const SizedBox(height: 20.0,),
          itemCount: data.length);
    }
  ); 
}
