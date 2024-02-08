import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/domain/usecase/add_chat_usercase.dart';
import 'package:messanger/features/messanger/domain/usecase/get_chat_list_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/get_message_list_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/send_message_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/update_last_message_use_case.dart';
import 'package:messanger/features/messanger/domain/usecase/user_exist_usecase.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserExistUseCase userExistUseCase;
  final AddChatUseCase addChatUseCase;
  final GetChatListUseCase getChatListUseCase;
  final GetMessageListUseCase getMessageListUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final UpdateLastMessageUseCase updateLastMessageUseCase;

  ChatBloc(this.userExistUseCase, this.addChatUseCase, this.getChatListUseCase,
      this.getMessageListUseCase, this.sendMessageUseCase,
      this.updateLastMessageUseCase)
      : super(ChatsLoadingState()) {
    on<AddChatEvent>(onAddChat);
    on<GetChatsEvent>(onGetChatList);
    on<GetMessagesEvent>(onGetMessageList);
    on<SendMessageEvent>(onSendMessage);
    on<MessageSeenEvent>(onUpdateMessage);
  }

  Future<void> onAddChat(AddChatEvent event, Emitter emitter) async {
    emitter(ChatsLoadingState());
    final result = await userExistUseCase.execute(event.phone);
    if (result.data != null) {
      final chatResult =
      await addChatUseCase.execute(
          ChatEntity(color: event.color), event.userId, result.data);
      if (chatResult is DataSuccess) {
        add(GetChatsEvent(userId: event.userId));
      }
      if(chatResult is DataError){
        emitter(ChatsErrorState(chatResult.message));
      }
    } else {
      emitter(NoUserForChatState("Пользователя с Таким номером не существует"));
    }
  }

  Future<void> onGetChatList(GetChatsEvent event, Emitter emitter) async {
    emitter(ChatsLoadingState());
    final result = await getChatListUseCase.execute(event.userId);
    if (result is DataSuccess) {
      emitter(ChatsSuccessState(result.data ?? []));
    } else if (result is DataError) {
      emitter(ChatsErrorState(result.message ?? "Unknown error"));
    }
  }

  Future<void> onGetMessageList(GetMessagesEvent event, Emitter emitter) async {
    emitter(MessagesLoadingState());
    final result = await getMessageListUseCase.execute(event.chatId);
    if (result is DataSuccess) {
      final messageList = result.data ?? [];
      emitter(MessagesSuccessState(messageList));
      if(messageList.isNotEmpty){
        await updateLastMessageUseCase.execute(event.chatId, messageList.last.id!);
      }
      for(var i=0;i<messageList.length;i++){
        if(messageList[i].senderId != event.userId && !messageList[i].isRed){
          add(MessageSeenEvent(messageList[i], event.chatId));
        }
      }
    } else if (result is DataError) {
      emitter(MessagesErrorState(result.message ?? "Unknown error"));
    }
  }

  Future<void> onSendMessage(SendMessageEvent event, Emitter emitter) async {
    final sendTime = DateTime.now();
    final messageEntity = MessageEntity(
        senderId: event.userId,
        message: event.message,
        isRed: false,
        timeStamp: sendTime
    );
    final result = await sendMessageUseCase.execute(
        event.chatId, messageEntity);
    if (result is DataSuccess) {
      add(GetMessagesEvent(event.chatId, event.userId));
    } else if (result is DataError) {
      emitter(MessagesErrorState(result.message ?? "Unknown error"));
    }
  }

  Future<void> onUpdateMessage(MessageSeenEvent event, Emitter emitter) async {
    final messageEntity = MessageEntity(
        id: event.messageEntity.id,
        senderId: event.messageEntity.senderId,
        message: event.messageEntity.message,
        timeStamp: event.messageEntity.timeStamp,
        isRed: true
    );
    final result = await sendMessageUseCase.execute(
        event.chatId, messageEntity);
     if (result is DataError) {
      emitter(MessagesErrorState(result.message ?? "Unknown error"));
    }
  }
}
