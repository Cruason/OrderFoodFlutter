import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';

abstract class ChatState{


}

class ChatsLoadingState extends ChatState{
  ChatsLoadingState();
}

class ChatsSuccessState extends ChatState{
  final List<ChatEntity>? chatList;

  ChatsSuccessState(this.chatList);
}

class ChatsErrorState extends ChatState{
  final String? message;
  ChatsErrorState(this.message);
}

class NoUserForChatState extends ChatState{
  final String? message;
  NoUserForChatState(this.message);
}

class MessagesSuccessState extends ChatState{
  final List<MessageEntity> messageList;

  MessagesSuccessState(this.messageList);
}

class MessagesLoadingState extends ChatState{
  MessagesLoadingState();
}

class MessagesErrorState extends ChatState{
  final String? message;

  MessagesErrorState(this.message);
}