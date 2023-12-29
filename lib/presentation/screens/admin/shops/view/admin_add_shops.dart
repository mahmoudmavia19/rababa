import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/presentation/common/component/admin_component/admin_small_button.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/resources/style/admin_style.dart';
import 'package:rababa/presentation/screens/admin/shops/view/admin_map.dart';
import 'package:rababa/presentation/screens/admin/shops/view_model/shops_view_model.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../resources/assets_manager.dart';

class AdminAddShop extends StatefulWidget {
  const AdminAddShop({Key? key}) : super(key: key);
  static final  ShopsViewModel viewModel = instance();
  @override
  State<AdminAddShop> createState() => _AdminAddShopState();
}

class _AdminAddShopState extends State<AdminAddShop> {

  @override
  void initState() {
    AdminAddShop.viewModel.start();
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0,toolbarHeight: 30.0),
      body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                ScreenTitle(title: AppStrings.addShop),
                const SizedBox(height: 20.0,) ,
                const Divider(thickness: 1.0,),
                const SizedBox(height: 80.0,),
               StreamBuilder<FlowState>(
                 stream:AdminAddShop.viewModel.outputState,
                   builder: (context, snapshot) =>snapshot.hasData?snapshot.data?.getScreenWidget(context, _scaffold(context),(){
                     if(snapshot.data?.getStateRendererType()==StateRendererType.fullScreenSuccessState)
                     {
                       Navigator.pop(context);
                     }
                   })??_scaffold(context) : _scaffold(context),)
              ],
            ),
          )),
    );
  }

  _scaffold(context)=>StreamBuilder<ShopModel>(
    stream: AdminAddShop.viewModel.shopOutput,
    builder: (context, snapshot) {
      var data = snapshot.data ;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.location ,
                style:AdminStyle.body36.copyWith(color: const Color(0xFF656262)
                ),
              ),
              const SizedBox(width: 30.0,),
              AdminSmallButton(title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.search,) ,
                    Expanded(
                        child: Text(
                          AppStrings.searchShops  ,
                          textAlign: TextAlign.center,
                          style: AdminStyle.body20.copyWith(color:const Color(0xFF656262) ),)),
                  ],
                ),
              ),
                adminSmallButtonStyle: AdminSmallButtonStyle(height: 37 , width: 178.0 , radius: 10.0)
                , onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminMap(),));
                },),
            ],
          ),
          if(data?.geoPoint!=null)
          Text(' موقع المتجر : ${data?.geoPoint!.latitude} , ${data?.geoPoint!.longitude} '),
          const SizedBox(height: 50.0,),
          AdminSmallButton(title: Image.asset(AppIcons.addIcon, width: 26.0 , height: 26.0,), onTap: () {
            AdminAddShop.viewModel.addShop();
          },adminSmallButtonStyle:AdminSmallButtonStyle(height:32.0 , width: 79 , radius: 10.0 ),)
        ],
      );
    }
  );
}
