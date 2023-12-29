import 'package:flutter/material.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';
import 'package:rababa/app/di.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/common/component/chat_list_item.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/screens/student/chat/view/chat_screen.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../resources/assets_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../view_model/chat_view_model.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatViewModel _viewModel = instance();
  final FocusNode _focusNode = FocusNode();
  bool search = false ;
  @override
  void initState() {
    _viewModel.getChatList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            setState(() {
              search = !search ;
            });
          }, icon:const Icon(Icons.search_sharp))
        ],
        toolbarHeight: 80.0,
        title:  Column(
          children: [
            const Text(AppStrings.chats , style: TextStyle(color: Colors.black , fontSize: 20.0),),
            if(search)
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFF68696C).withOpacity(0.17),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              height: 35.0,
              child:
              StreamBuilder<List<UserMessage>>(
                  stream: _viewModel.chatListOutput,
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    return Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF68696C).withOpacity(0.17),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      height: 35.0,
                      child: KeyboardVisibility(
                        onChanged: (p0){
                          if(!p0)
                          _focusNode.unfocus();
                        },
                        child: SearchField<UserModel>(
                          focusNode: _focusNode,
                          hint: AppStrings.teacherSearch,

                          onSuggestionTap: (p0) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userModel: p0.item!),)) ;
                          },
                          searchInputDecoration: InputDecoration(
                            hintStyle:const TextStyle(fontSize: 18.0,color: Color(0xFFC4C4C4),height: 2.5),
                            prefixIcon: const Icon(Icons.search_sharp,color: Color(0xFFAFADAD),),
                            hintText: AppStrings.teacherSearch,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                            focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color:const Color(0xFF68696C).withOpacity(0.17))),
                          ),
                          searchStyle:const TextStyle(fontSize: 18.0,height: 2) ,

                          suggestions: data == null ? [] :  data.map((e) => SearchFieldListItem<UserModel>(e.user!.name! ,
                              item: e.user ,
                              child: Container(color: Colors.white,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius:40,
                                      backgroundColor: Colors.white,
                                      backgroundImage:e.user!.imgUrl==null ? AssetImage(AppIcons.defaultImg) as ImageProvider:  NetworkImage(e.user!.imgUrl!),
                                    ),
                                    Text(e.user!.name??''),
                                  ],
                                ),
                              )
                          )
                          ).toList(),

                        ),
                      ),
                    );
                  }
              ),

            )
          ],
        )
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) => snapshot.data?.getScreenWidget(context, _widget(), (){
          _viewModel.getChatList();
        })??Container(),
      ) ,
      /*floatingActionButton: FloatingActionButton(onPressed: () {

      },child:Image.asset(AppIcons.message , color: Colors.white,) ,),*/
    ) ;
  }

  _widget()=>StreamBuilder<List<UserMessage>>(
    stream: _viewModel.chatListOutput,
    builder: (context, snapshot) {
      var data = snapshot.data;
      return data ==null ?  Container() : Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 30.0,
          ),
          itemBuilder: (context, index) => ChatListItem(user: data[index],) ,
          itemCount: data.length,
        ),
      );
    }
  );
}
