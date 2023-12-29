import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/screens/student/group_item/shops_view_model/view_model/view_model.dart';

import '../../../../../../app/di.dart';

class ShopsItem extends StatefulWidget {
  const ShopsItem({Key? key}) : super(key: key);

  @override
  State<ShopsItem> createState() => _ShopsItemState();
}

class _ShopsItemState extends State<ShopsItem>  with AutomaticKeepAliveClientMixin<ShopsItem> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  final StudentShopsViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  StreamBuilder(
      stream: _viewModel.outputState,
        builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _map(), (){
          _viewModel.start();
        }) ?? Container(),);
  }

  _map()=>StreamBuilder<List<ShopModel>>(
    stream: _viewModel.controller.stream,
    builder: (context, snapshot) {
       var data = snapshot.data;
      return data ==null ? Container() :  GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.63333, 46.71667),
          zoom: 12,
        ),
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        gestureRecognizers: {
          Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
          Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
          ),
        } ,
        markers: {
          for(var item in data)
            Marker(
            markerId: MarkerId(item.id!),
            position:LatLng(item.geoPoint!.latitude, item.geoPoint!.longitude),
          ),
        },
      );
    }
  );

  @override
  bool get wantKeepAlive => true ;
}
