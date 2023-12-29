import 'package:flutter/material.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/presentation/common/component/admin_component/screen_title.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/admin/complaint_screen/view_model/complaint_view_model.dart';
import '../../../../../../data/model/complaint_model.dart';

import '../../../../common/component/admin_component/admin_complaint_item.dart';

class AdminComplaint extends StatefulWidget {
  const AdminComplaint({Key? key}) : super(key: key);

  @override
  State<AdminComplaint> createState() => _AdminComplaintState();
}

class _AdminComplaintState extends State<AdminComplaint> {

  final AdminComplaintViewModel _viewModel = instance();
  _bind(){
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, toolbarHeight: 30.0 , ),
      body:Column(
        children: [
          ScreenTitle(title: AppStrings.complaint),
          const SizedBox(height: 20.0,) ,
          Expanded(
            child: StreamBuilder<FlowState>(
              stream: _viewModel.outputState,
              builder: (context, snapshot) => snapshot.data?.getScreenWidget(context,  _scaffold(), (){
                _bind();
              })??Container(),
            ),
          )
        ],
      ) ,
    );
  }

  _scaffold()=>StreamBuilder<List<ComplaintModel>>(
    stream: _viewModel.complaintOutput,
    builder: (context, snapshot) {
      var data = snapshot.data ;
      return data!=null ? RefreshIndicator(
        onRefresh: () async{
          _bind();
        },
        child: ListView.builder(
          itemBuilder:(context, index) {
            return AdminComplaintItem(complaintModel:data[index] , isLast: (data.length-1)==index,);
          },
          itemCount: data.length,
        ),
      ) : Container();
    }
  );
}
