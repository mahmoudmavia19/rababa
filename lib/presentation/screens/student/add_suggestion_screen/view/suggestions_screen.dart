import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/add_suggestion_screen/view_model/add_suggestion_view_model.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final AddSuggestionViewModel _viewModel = instance();

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
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor2,
      appBar: AppBar(backgroundColor: AppColor.scaffoldBackgroundColor2,elevation: 0.0,),
      body:StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffoldWidgets(), (){
          if(snapshot.data!.getStateRendererType() == StateRendererType.fullScreenSuccessState)
            {
              Navigator.pop(context);
            }
        })??Container()
      )
    );
  }

  _scaffoldWidgets()=> SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: [
        const  Text(AppStrings.suggestion, style: TextStyle(fontSize:24.0),),
        const  SizedBox(height: 20.0,),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: TextFormField(
            maxLines: 10,
            onChanged: (value) {
              _viewModel.setSuggestion(value);
            },
            decoration: InputDecoration(
                hintText: 'نرحب بشكاويكم و إقتراحاتكم بكل حب ',
                focusedBorder:  OutlineInputBorder(borderSide: const BorderSide(color: Colors.white,), borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white,), borderRadius: BorderRadius.circular(10.0))
            ),
          ),
        ) ,
        const SizedBox(height: 100.0,),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)
          ),
          width: double.infinity,
          child: MaterialButton(onPressed: (){
            _viewModel.addSuggestion();
          },
            color: AppColor.primary[600],
            child: const Text(AppStrings.send ,style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 38.0), ),),
        )
      ],
    ),
  );
}
