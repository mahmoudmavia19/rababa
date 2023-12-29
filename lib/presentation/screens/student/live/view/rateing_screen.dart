import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/presentation/common/component/customButton.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';

import '../view_model/rate_view_model.dart';

class RatingScreen extends StatefulWidget {
    RatingScreen({Key? key, required this.order}) : super(key: key);
    OrderModel? order ;
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final RateViewModel _viewModel = instance();

  @override
  void initState() {
   _viewModel.setTeacherId(widget.order!.teacherId!);
   _viewModel.setComment('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        centerTitle: true,
        elevation: 0.0,
        title: Image.asset(AppIcons.logo),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(context, _scaffold(context), (){
                if(snapshot.data?.getStateRendererType()==StateRendererType.fullScreenSuccessState){
                  Navigator.pop(context);
                }
              })??_scaffold(context) ;
            }
          ),
        ),
      ),
    );
  }

  _scaffold(context)=>Column(
    children: [
      Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context) ;
            },
              child: Image.asset(AppIcons.cancel))) ,
      const SizedBox(height: 20.0,),
      Text('تقييم الخدمة ', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColor.primary),),
      const SizedBox(height: 20.0,),
      StreamBuilder<double>(
        stream: _viewModel.ratingController.stream,
        builder: (context, snapshot) {
          return RatingBar(
            itemCount: 5,
            itemSize: 70.0,
            initialRating:snapshot.data??0.0,
            unratedColor: Colors.grey,
            onRatingUpdate: (value) {
              _viewModel.ratingController.sink.add(value);
              _viewModel.setRate(value);
            }, ratingWidget:RatingWidget(full:  const Icon(Icons.star,color: Colors.amber), half: const Icon(Icons.star_border_purple500,color: Colors.amber,), empty: const Icon(Icons.star_border)),);
        }
      ) ,
      const SizedBox(height: 20.0,),
      Text('رأيك يهمنا', style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 20.0,),
      TextFormField(
        maxLines: 10,
        onChanged: (value) {
          _viewModel.setComment(value);
        },
        decoration: const InputDecoration(
            hintText: ' شاركنا برأيك وذلك لمساعدتنا على تقديم خدمة أفضل',
            border: OutlineInputBorder()

        ),
      ),
      const SizedBox(height: 20.0,),
      CustomButton(title:'التقييم' , onTap: (){
        _viewModel.ratingTeacher();
        /* showDialog(context: context, builder: (context) =>const Dialog(
          backgroundColor: Colors.transparent,
          child:  CircleAvatar(
            child: Icon(Icons.check,size: 50.0,),
            radius: 50.0,
          ),
        ));*/
      })
    ],

  );
}
