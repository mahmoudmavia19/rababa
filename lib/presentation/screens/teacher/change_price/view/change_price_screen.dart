
import 'package:flutter/material.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/update_profile_screen/view_model/update_profile_view_model.dart';

import '../../../../../app/di.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../teacher_main_screen/view/teacher_main_screen.dart';

class ChangePriceScreen extends StatefulWidget {
    ChangePriceScreen({Key? key}) : super(key: key);

  @override
  State<ChangePriceScreen> createState() => _ChangePriceScreenState();
}

class _ChangePriceScreenState extends State<ChangePriceScreen> {
  final UpdateProfileViewModel _viewModel = instance();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2ADD5),
        elevation: 0.0,
      ),
      backgroundColor: AppColor.scaffoldBackgroundColor2,
      body:StreamBuilder(
        stream: _viewModel.outputState,
        builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(context),() async{
          Navigator.pop(context)  ;
        })??_scaffold(context),
      )
    ) ;
  }

  _scaffold(context)=>SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(AppIcons.background2,width: double.infinity,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                height:150,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius:31.71,
                          backgroundColor: Colors.white,
                          onBackgroundImageError: (exception, stackTrace) =>AssetImage(AppIcons.defaultImg,),
                          backgroundImage: AssetImage(AppIcons.defaultImg),
                        ),
                        const SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppConstant.userObject!.name??'',style: Theme.of(context).textTheme.bodyLarge,),
                            Text(AppConstant.userObject!.username??'',style: Theme.of(context).textTheme.bodyLarge,),
                          ],
                        ),
                        const Spacer(),
                        IconButton( onPressed: () {
                          Navigator.pop(context);
                        },  icon: const Icon(Icons.arrow_forward_ios)),
                        const SizedBox(width: 10.0,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.changePrice , style: Theme.of(context).textTheme.titleSmall,) ,
              const SizedBox(height: 20.0,) ,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      height: 50.0,
                      child: TextFormField(
                        onChanged: (value) {
                          _viewModel.updatePrice('${value}SR') ;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20.0)
                            )
                        ),
                      ),
                    ),
                  ) ,
                  const SizedBox(width: 10.0,) ,
                  Card(
                      color: AppColor.scaffoldBackgroundColor2,
                      elevation: 5.0,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 12.0),
                        child: Text('SR',style: Theme.of(context).textTheme.titleMedium,),
                      )
                  )
                ],
              ) ,
              const SizedBox(height: 70.0,) ,
              CustomButton(title: AppStrings.ok, onTap: () {
                _viewModel.updateProfile();

              },)
            ],
          ),
        )
      ],
    ),
  );
}
