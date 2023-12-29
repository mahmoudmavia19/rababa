import 'dart:async';

import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/chat_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/domain/usecase/get_list_of_users_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/chat_usecases/clean_unseen_usecase.dart';
import '../../../../../domain/usecase/chat_usecases/get_all_chat_usecase.dart';
import '../../../../../domain/usecase/chat_usecases/last_message.dart';
import '../../../../../domain/usecase/chat_usecases/send_message_usecase.dart';
import '../../../../../domain/usecase/chat_usecases/unseen_usecase.dart';
import '../../../../../domain/usecase/get_chat_users_unfollow_usecase.dart';

class ChatViewModel extends BaseViewModel
    with ChatViewModelInput, ChatViewModelOutput {
  final StreamController<List<UserMessage>> _chatListController =
      BehaviorSubject<List<UserMessage>>();
  final StreamController<List<ChatModel>> _chatController =
      BehaviorSubject<List<ChatModel>>();

  GetListOfUsersUseCase getListOfUsersUseCase;
  SendMessageUseCase sendMessageUseCase;
  GetAllChatUseCase getAllChatUseCase;
  UnSeenUseCase unSeenUseCase;
  LastMessageUseCase lastMessageUseCase;
  CleanUnSeenUseCase cleanUnSeenUseCase;
  GetChatUsersUnfollowUseCase getChatUsersUnfollowUseCase;
  String? currentMessage;
  UserModel? antherUser;
  List<String> unFollowUsersChat = [];
  Map<String, UserMessage> lastMessages = {};

  ChatViewModel(
      this.sendMessageUseCase,
      this.getListOfUsersUseCase,
      this.getAllChatUseCase,
      this.unSeenUseCase,
      this.lastMessageUseCase,
      this.cleanUnSeenUseCase,
      this.getChatUsersUnfollowUseCase);

  @override
  void start() {}

  @override
  sendMessage() async {
    if (antherUser != null) {
      if (currentMessage == null || currentMessage == '') {
        inputState.add(ErrorState(
            StateRendererType.popupErrorState, AppStrings.cnSendEMessage));
      } else {
        (await sendMessageUseCase.execute(SendMessageUseCaseInput(
                antherUser!.uid,
                ChatModel(currentMessage, AppConstant.userObject!.uid,
                    antherUser!.uid, false, DateTime.now()))))
            .fold((l) {
          inputState
              .add(ErrorState(StateRendererType.popupErrorState, l.message));
        }, (r) {});
      }
    } else {
      inputState.add(
          ErrorState(StateRendererType.popupErrorState, AppStrings.cantEmpty));
    }
  }

  @override
  setMessage(String message) {
    currentMessage = message;
  }

  @override
  setAntherUser(UserModel userModel) {
    antherUser = userModel;
  }

  @override
  getChatList() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await getChatUsersUnfollowUseCase.execute(AppConstant.nullVoid()))
        .fold((l) {}, (unFollowUsers) async {

          List<String> users = [] ;
          for(var user in AppConstant.userObject!.following!){
            users.add(user) ;
          }
          for(var user in unFollowUsers){
            if(!users.contains(user)) {
              users.add(user) ;
            }
          }
          print(users);
      (await getListOfUsersUseCase.execute(users))
          .fold((l) {
        inputState
            .add(ErrorState(StateRendererType.fullScreenErrorState, l.message));
      }, (r) async {
        // end
        for (var item in r) {
          lastMessages.addAll({
            item.uid!: UserMessage(
                item,
                lastMessages.containsKey(item.uid)
                    ? lastMessages[item.uid]!.unSeenMessages
                    : null)
          });
          getUnseenMessages(item.uid!);
        }
        chatListInput.add(lastMessages.values.toList());
        inputState.add(ContentState());
      });
    });
  }

  @override
  Sink<List<UserMessage>> get chatListInput => _chatListController.sink;

  @override
  Stream<List<UserMessage>> get chatListOutput =>
      _chatListController.stream.map((event) => event);

  @override
  Sink get chatInput => _chatController.sink;

  @override
  Stream<List<ChatModel>> get chatOutput =>
      _chatController.stream.map((event) => event);

  @override
  getChat() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllChatUseCase.execute(antherUser!.uid!)).fold((l) {
      inputState
          .add(ErrorState(StateRendererType.fullScreenErrorState, l.message));
    }, (r) {
      List<ChatModel> list = [];
      r!.listen((event) {
        list = [];
        for (var element in event.docs) {
          list.add(ChatModel.fromJson(element.data()));
        }
        chatInput.add(list.reversed.toList());
      });

      inputState.add(ContentState());
    });
  }

  @override
  getUnseenMessages(String uid) async {
    UnSeenMessages unSeenMessages = UnSeenMessages();
    (await lastMessageUseCase.execute(uid)).fold((l) {}, (lastSeen) async {
      lastSeen!.listen((event) {
        unSeenMessages.lastMessage = ChatModel.fromJson(event.data()!);
        lastMessages[uid] =
            UserMessage(lastMessages[uid]!.user, unSeenMessages);
        print(lastMessages[uid]?.unSeenMessages?.lastMessage?.message);
        chatListInput.add(lastMessages.values.toList());
      });
    });
    (await unSeenUseCase.execute(uid)).fold((l) {}, (unseen) {
      unseen!.listen((event) {
        unSeenMessages.unseen = event.docs.length;
        lastMessages[uid] =
            UserMessage(lastMessages[uid]!.user, unSeenMessages);
        chatListInput.add(lastMessages.values.toList());
        print(event.docs.length);
      });
    });
  }

  @override
  cleanUnSeenMessages(String uid) async {
    (await cleanUnSeenUseCase.execute(uid)).fold((l) {}, (r) {});
  }

  @override
  getUnFollowingUsersChat() async {
    (await getChatUsersUnfollowUseCase.execute(AppConstant.nullVoid()))
        .fold((l) {}, (r) {
      for (var i in r) {
        unFollowUsersChat.add(i);
      }
    });
  }
}

abstract class ChatViewModelOutput {
  Stream<List<UserMessage>> get chatListOutput;
  Stream<List<ChatModel>> get chatOutput;
}

abstract class ChatViewModelInput {
  Sink<List<UserMessage>> get chatListInput;
  Sink get chatInput;
  sendMessage();
  setMessage(String message);
  setAntherUser(UserModel userModel);
  getChatList();
  getChat();
  getUnFollowingUsersChat();
  getUnseenMessages(String uid);
  cleanUnSeenMessages(String uid);
}
