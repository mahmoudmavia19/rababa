import 'package:flutter/material.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:timeago/timeago.dart';

import '../../resources/assets_manager.dart';
import '../../screens/student/chat/view/chat_screen.dart';

class ChatListItem extends StatelessWidget {
  ChatListItem({Key? key ,required this.user}) : super(key: key);
  UserMessage user ;
  @override
  Widget build(BuildContext context) {
    var lastMessage  = user.unSeenMessages;
    return    InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userModel:user.user!),));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius:31.71,
            backgroundColor: Colors.white,
            backgroundImage:user.user!.imgUrl==null?   AssetImage(AppIcons.defaultImg) as ImageProvider  :  NetworkImage(user.user!.imgUrl!,),
          ),
          const SizedBox(width: 10.0,),
          Column(children:   [
            Text(user.user!.name??'', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xFF213241))),
            const SizedBox(height:5.0,) ,
            Text(user.unSeenMessages?.lastMessage!.message??'', style:  Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xFF8593A8))),
          ],) ,
          const Spacer(),
          Column(children:  [
            Text(format(user.unSeenMessages?.lastMessage!.date??DateTime.now(),locale: 'ar', allowFromNow: true), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xFF8593A8))),
            const SizedBox(height: 10.0,) ,
            user.unSeenMessages?.unseen==0? Container():  CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 10.0,
              child: Text(user.unSeenMessages?.unseen.toString()??'',style: Theme.of(context).textTheme.caption!.copyWith(color:Colors.white)),
            )
          ],) ,
        ],
      ),
    ) ;
  }
}
