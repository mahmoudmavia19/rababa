import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/chat_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rababa/presentation/screens/student/chat/view_model/chat_view_model.dart';
import 'package:timeago/timeago.dart';

class ChatScreen  extends StatefulWidget {
    ChatScreen ({Key? key ,required this.userModel}) : super(key: key);
    UserModel userModel ;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatViewModel _viewModel= instance();
  final TextEditingController _messageText = TextEditingController() ;

  @override
  void initState() {
    _viewModel.setAntherUser(widget.userModel);
    _viewModel.getChat();
    _viewModel.cleanUnSeenMessages(widget.userModel.uid!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(AppIcons.logo),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<FlowState>(
                stream: _viewModel.outputState,
                builder: (context, snapshot) {
                  return snapshot.data?.getScreenWidget(context, _widget(), (){})??Container() ;
                }
              ),
            ),
            SizedBox(
              height: 70.0,
              child: TextFormField(
                controller: _messageText,
                onChanged: (value) {
                  _viewModel.setMessage(value);
                },
                decoration: InputDecoration(
                   enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)) ,
                  focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(13.0)) ,
                  hintText:AppStrings.write ,
                  suffixIcon:   Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _viewModel.sendMessage();
                        _messageText.clear();
                      },
                      child: const CircleAvatar(
                        radius: 23.0,
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  )

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _widget()=>StreamBuilder<List<ChatModel>>(
    stream: _viewModel.chatOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      print('--------------------------------------------------------------');
      return data ==null ? Container()  :
      ListView.separated(itemBuilder: (context, index) =>Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppConstant.userObject!.uid==data[index].sender ?  AppColor.primary :Colors.grey ,
            borderRadius: BorderRadius.circular(25.0)
          ),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text('${data[index].message}' , style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
                const Spacer() ,
                Text(format(data[index].date!,locale: 'ar'), style: Theme.of(context).textTheme.caption,),
              ],
            )),
      ),
          reverse: true,
          separatorBuilder: (context, index) => Container(), itemCount: data.length);
    }
  ) ;
}
