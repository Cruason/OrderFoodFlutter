import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';

abstract class MessageRepository {
  Future<DataState<List<MessageEntity>>> getMessages(int? chatId);

  Future<DataState<void>> addMessage(int? chatId,MessageEntity messageEntity);

  Future<DataState<List<ChatEntity>>> getChats(int? userId);

  Future<DataState<void>> addLastMessage(
      int? chatId, int? messageId);

  Future<DataState<void>> addChat(ChatEntity chatEntity, int? firstUserId, int? secondUserId);

  Future<DataState<UserEntity?>> registerUser(UserEntity userEntity);

  Future<DataState<UserEntity?>> loginUser(String phone);
  Future<DataState<int?>> userExist(String phone);
}
