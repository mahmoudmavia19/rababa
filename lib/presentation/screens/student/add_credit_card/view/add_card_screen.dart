import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/credet_card_utils/card_number_formatter.dart';
import 'package:rababa/presentation/common/credet_card_utils/credet_card.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/add_credit_card/view_model/add_credit_card_view_model.dart';

class AddNewCard extends StatefulWidget {
    const AddNewCard({Key? key}) : super(key: key);

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {

  final AddCreditCardViewModel _viewModel = instance();
  _bind() {
   _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColor.scaffoldBackgroundColor2,elevation: 0.0,),
      backgroundColor: AppColor.scaffoldBackgroundColor2,
      body: StreamBuilder<FlowState>(
      stream:_viewModel.outputState ,
      builder: (context, snapshot) =>snapshot.data?.getScreenWidget(context, _scaffoldWidgets(), (){
        if(snapshot.data!.getStateRendererType()==StateRendererType.fullScreenSuccessState)
          {
            Navigator.pop(context);
          }
      })?? _scaffoldWidgets() ,
      )

    );
  }

  _scaffoldWidgets()=>SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Expanded(flex : 1,  child: Text(AppStrings.cardNumber, style: TextStyle(fontSize: 24.0),)),
              const SizedBox(width: 20.0,),
              Expanded(
                flex: 3,
                child: Container(
                  height: 28.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: StreamBuilder<CCNumValidationResults>(
                    stream: _viewModel.cardOutput,
                    builder: (context, snapshot) {
                      if(snapshot.data!=null)
                        {
                          print(snapshot.data!.ccType);
                          print('==============================');
                          print(snapshot.data!.isValid);
                          print('==============================');
                        }
                      return Directionality( 
                        textDirection: TextDirection.ltr,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _viewModel.setCreditCardNumber(value);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            CardNumberFormatter(),
                          ],
                          decoration: InputDecoration(
                            suffixIcon:snapshot.data ==null ? CreditCardUtils.cardIcon(CreditCardType.unknown):
                            snapshot.data!.ccType.toString()==CreditCardType.visa.toString()?
                            CreditCardUtils.cardIcon(CreditCardType.visa) :
                            snapshot.data!.ccType.toString()==CreditCardType.mastercard.toString()?
                            CreditCardUtils.cardIcon(CreditCardType.mastercard):   CreditCardUtils.cardIcon(CreditCardType.unknown) ,
                            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
              const SizedBox(width: 20.0,),
            ],
          ) ,
          const SizedBox(height: 20.0,),
          _cellTextField(AppStrings.cardName) ,
          const SizedBox(height: 20.0,),
          Row(children: [
            const Text(AppStrings.cardExDate, style: TextStyle(fontSize: 24.0),),
            const SizedBox(width:20.0) ,
            Expanded(
              child: StreamBuilder<String>(
                stream: _viewModel.monthCon.stream,
                builder: (context, snapshot) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        width: 100.0,
                        height: 28.0,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            icon: Container(),
                            isExpanded: true,
                            value: snapshot.data,
                            hint: const Text('الشهر'),
                            underline: Container(), items:
                          _viewModel.getAllMonths().map((e) => DropdownMenuItem<String>(value: e.toString(),child: Text(e.toString()),)).toList()
                            , onChanged: (value) {
                              _viewModel.monthCon.add(value!);
                              _viewModel.setMonth(value);
                          },),
                        ),
                      ),
                    ]
                  );
                }
              ),
            ),
            Expanded(
              child: StreamBuilder<String>(
                stream: _viewModel.yearCon.stream ,
                builder: (context, snapshot) {
                  return Flex(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          width: 100.0,
                          height: 28.0,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: DropdownButton<String>(
                            icon: Container(),
                            isExpanded: true,
                            value: snapshot.data,
                            hint:const Text('السنه'),
                            underline: Container(), items:
                          _viewModel.getAllYears().map((e) => DropdownMenuItem<String>(value: e.toString(),child: Text(e.toString()),)).toList()
                            , onChanged: (value) {
                              _viewModel.yearCon.add(value!);
                              _viewModel.setYear(value);
                          },),
                        ),
                      ]
                  );
                }
              ),
            ),
          ],),
          const SizedBox(height: 100.0,),
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
               _viewModel.addCreditCard();
              },
                color: AppColor.primary[600],
                child: const Text(AppStrings.add ,style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 38.0), ),),
            ),
          )
        ],
      ),
    ),
  );

  _cellTextField(text,)=>
  Row(
    children: [
      Expanded(flex : 1,  child: Text(text, style: const TextStyle(fontSize: 24.0),)),
      const SizedBox(width: 20.0,),
      Expanded(
        flex: 3,
        child: Container(
          height: 28.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$'))
            ],
            onChanged: (value) {
              _viewModel.setCardName(value);
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ),
      const SizedBox(width: 20.0,),
    ],
  ) ;
}
