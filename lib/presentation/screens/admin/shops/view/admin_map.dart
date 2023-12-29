import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/resources/style/admin_style.dart';

import 'admin_add_shops.dart';
class AdminMap extends StatefulWidget {
  const AdminMap({Key? key}) : super(key: key);

  @override
  State<AdminMap> createState() => _AdminMapState();
}

class _AdminMapState extends State<AdminMap> {
  LatLng?  currentMark ;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.selectShopLocation , style: AdminStyle.body36,),centerTitle: true , backgroundColor:AppColor.primary,),
      body: StreamBuilder<FlowState>(
        stream: AdminAddShop.viewModel.outputState,
          builder:(context, snapshot) => snapshot.data?.getScreenWidget(context, _map(), (){
            if(snapshot.data?.getStateRendererType()==StateRendererType.fullScreenSuccessState)
              {
                Navigator.pop(context);
              }
          }) ?? _map() ,) ,
      floatingActionButton: FloatingActionButton(onPressed: (){
        AdminAddShop.viewModel.setLocation(currentMark!);
        Navigator.pop(context);
      } , child: Image.asset(AppIcons.addIcon),),
    );
  }

  _map()=>GoogleMap(
    onTap: (argument) {
      setState(() {
        currentMark = argument ;
      });
      print(argument);
    },
    initialCameraPosition: const CameraPosition(
      target: LatLng(24.63333, 46.71667),
      zoom: 12,
    ),
    markers: {
      Marker(
        markerId: const MarkerId('marker_1'),
        position: currentMark?? const LatLng(24.63333, 46.71667),
      ),
    },
  );
}
