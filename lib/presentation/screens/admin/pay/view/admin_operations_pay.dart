import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import '../../../../common/component/admin_component/admin_order_item.dart';
import '../view_model/admin_pay_view_model.dart';

class AdminOperationsPay extends StatefulWidget {
  const AdminOperationsPay({Key? key}) : super(key: key);

  @override
  State<AdminOperationsPay> createState() => _AdminOperationsPayState();
}

class _AdminOperationsPayState extends State<AdminOperationsPay> {

  final  AdminPayOperationsViewModel _viewModel = instance();
  @override
  void initState() {
    _viewModel.start() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, toolbarHeight: 30.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenTitle(title: AppStrings.operationPay),
            const SizedBox(height: 20.0,),
            StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) {
                return snapshot.data?.getScreenWidget(context, _viewList(), (){})??Container();
              }
            )
          ],
        ),
      ),
    );
  }


  _viewList()=>StreamBuilder<List<OrderModel>>(
    stream: _viewModel.ordersStreamCon.stream,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data==null ?  Container() :ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:data.length,
        itemBuilder: (context, index) => AdminOrderItem(orderModel: data[index] , isLast: (data.length-1)==index),);
    }
  );
}
