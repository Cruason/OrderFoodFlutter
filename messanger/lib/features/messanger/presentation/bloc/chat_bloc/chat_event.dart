import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';

abstract class ChatEvent {
  ChatEvent();
}

class GetChatsEvent extends ChatEvent {
  final int userId;

  GetChatsEvent({required this.userId});
}

class AddChatEvent extends ChatEvent {
  final ProfileColor? color;
  final int userId;
  final String phone;

  AddChatEvent({this.color, required this.userId, required this.phone});
}

class SendMessageEvent extends ChatEvent{
  final int userId;
  final int chatId;
  final String? message;

  SendMessageEvent({this.message, required this.userId, required this.chatId});
}
class GetMessagesEvent extends ChatEvent{
  final int userId;
  final int chatId;
  GetMessagesEvent(this.chatId, this.userId);
}
class MessageSeenEvent extends ChatEvent{
  final int chatId;
  final MessageEntity messageEntity;
  MessageSeenEvent(this.messageEntity, this.chatId);
}

class UpdateLastMessageEvent extends ChatEvent{
  final int chatId;
  final int messageId;

  UpdateLastMessageEvent({required this.chatId, required this.messageId});
}