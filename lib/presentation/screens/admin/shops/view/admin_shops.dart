import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/presentation/common/component/admin_component/admin_small_button.dart';
import 'package:rababa/presentation/common/component/admin_component/listview_item.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/admin/shops/view_model/shops_view_model.dart';

import 'admin_add_shops.dart';

class AdminShops extends StatefulWidget {
  const AdminShops({Key? key}) : super(key: key);

  @override
  State<AdminShops> createState() => _AdminShopsState();
}

class _AdminShopsState extends State<AdminShops> {
  final ShopsViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.getShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, toolbarHeight: 30.0),
      body: Column(
         children: [
            ScreenTitle(title: AppStrings.shops),
           const SizedBox(height: 20.0,),
           Expanded(
             child: StreamBuilder<FlowState>(
               stream: _viewModel.outputState,
                 builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _scaffold(), (){})??Container(),),
           ) ,
           AdminSmallButton(title: Image.asset(AppIcons.addIcon, width: 26.0 , height: 26.0,), onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminAddShop(),));

           },adminSmallButtonStyle:AdminSmallButtonStyle(height:32.0 , width: 79 , radius: 10.0 ),),
           const SizedBox(height: 20.0,),
         ],
      ),
    ) ;
  }

  _scaffold()=>StreamBuilder<List<ShopModel>>(
    stream: _viewModel.shopsOutput,
    builder: (context, snapshot) {
      var data = snapshot.data ;
      print(data?.length) ;
      return data ==null ? Container() : RefreshIndicator(
        onRefresh: () async {
          await _viewModel.getShops();
        },
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) =>  ListViewItem(title: AppStrings.shopNumber , subtitle: data[index].id! , buttonContent: Image.asset(AppIcons.removeIcon , width:26 , height: 26.0 ,),onTap: () {
            _viewModel.deleteShop(data[index]);
          },adminSmallButtonStyle: AdminSmallButtonStyle(height:32.0 , width: 79 , radius: 10.0 ),isLast: (data.length-1)==index,),
        ),
      );
    }
  );
}
