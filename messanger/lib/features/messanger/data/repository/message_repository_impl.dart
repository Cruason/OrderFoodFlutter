import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/data/data_sources/local/app_database.dart';
import 'package:messanger/features/messanger/data/model/chat_model.dart';
import 'package:messanger/features/messanger/data/model/message_model.dart';
import 'package:messanger/features/messanger/data/model/user_model.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class MessageRepositoryImpl extends MessageRepository {
  final AppDataBase appDataBase;

  MessageRepositoryImpl({required this.appDataBase});

  @override
  Future<DataState<void>> addChat(
      ChatEntity chatEntity, int? firstUserId, int? secondUserId) async {
    try {
      final resOne = await appDataBase.chatDao.getChatsByUser(firstUserId!);
      if (resOne.isNotEmpty) {
        for (final chat in resOne) {
          if(chat.secondUserId == secondUserId || chat.firstUserId == secondUserId){
            return DataError("У вас уже есть чат с этим пользователем");
          }
        }
      }
      await appDataBase.chatDao.insertChat(ChatModel(
          firstUserId: firstUserId,
          secondUserId: secondUserId,
          color: chatEntity.color));
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> addLastMessage(int? chatId, int? messageId) async {
    try {
      var chatModel = await appDataBase.chatDao.getChatById(chatId!);
      chatModel = chatModel?.copyWith(lastMessageId: messageId);
      await appDataBase.chatDao.insertChat(chatModel!);
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<void>> addMessage(
      int? chatId, MessageEntity messageEntity) async {
    try {
      await appDataBase.messageDao.insertMessage(MessageModel(
          id: messageEntity.id,
          chatId: chatId,
          senderId: messageEntity.senderId,
          message: messageEntity.message,
          timeStampMillis: messageEntity.timeStamp?.millisecondsSinceEpoch,
          isRed: messageEntity.isRed));
      return DataSuccess(null);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<ChatEntity>>> getChats(int? userId) async {
    try {
      List<ChatEntity> chatList = [];
      final chatModels = await appDataBase.chatDao.getChatsByUser(userId!);
      for (var i = 0; i < chatModels.length; i++) {
        final String chatName;
        if (chatModels[i].firstUserId != userId) {
          final user =
              await appDataBase.userDao.getUserById(chatModels[i].firstUserId!);
          chatName = user?.userName ?? "";
        } else {
          final user = await appDataBase.userDao
              .getUserById(chatModels[i].secondUserId!);
          chatName = user?.userName ?? "";
        }
        final MessageModel? messageModel;
        if (chatModels[i].lastMessageId != null) {
          messageModel = await appDataBase.messageDao
              .getMessageById(chatModels[i].lastMessageId!);
        } else {
          messageModel = null;
        }
        final chatEntity = ChatEntity(
            id: chatModels[i].id,
            chatName: chatName,
            color: chatModels[i].color,
            messageEntity: MessageEntity(
              id: messageModel?.id,
              senderId: messageModel?.senderId,
              message: messageModel?.message,
              timeStamp:
                  (messageModel != null && messageModel.timeStampMillis != null)
                      ? DateTime.fromMillisecondsSinceEpoch(
                          messageModel.timeStampMillis!)
                      : null,
              isRed: messageModel?.isRed ?? false,
            ));
        chatList.add(chatEntity);
      }
      return DataSuccess(chatList);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<List<MessageEntity>>> getMessages(int? chatId) async {
    try {
      final messageModels =
          await appDataBase.messageDao.getMessagesByChat(chatId!);
      final messageEntities = List<MessageEntity>.from(messageModels.map((e) {
        return MessageEntity(
            id: e.id,
            senderId: e.senderId,
            message: e.message,
            isRed: e.isRed ?? false,
            timeStamp: DateTime.fromMillisecondsSinceEpoch(e.timeStampMillis!));
      }));
      return DataSuccess(messageEntities);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> loginUser(String phone) async {
    try {
      final user = await appDataBase.userDao.getUserByPhone(phone);
      final userEntity = UserEntity(
        id: user?.id,
        username: user?.userName,
        phone: user?.phone,
      );
      return DataSuccess(userEntity);
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<UserEntity>> registerUser(UserEntity userEntity) async {
    try {
      if(userEntity.phone != null){
        final user = await userExist(userEntity.phone!);
        print( user.data);
        if(user.data != null){
          return DataError("Такой пользователь существует");
        }
      }
      final userModel = UserModel(
        id: userEntity.id,
        userName: userEntity.username,
        phone: userEntity.phone,
      );
      await appDataBase.userDao.insertUser(userModel);
      final result = await loginUser(userEntity.phone!);
      if (result is DataSuccess) {
        return DataSuccess(result.data ?? UserEntity());
      } else {
        return DataError(result.message ?? "UnknownError");
      }
    } catch (e) {
      return DataError(e.toString());
    }
  }

  @override
  Future<DataState<int?>> userExist(String phone) async {
    try {
      final user = await appDataBase.userDao.getUserByPhone(phone);
      return DataSuccess(user?.id);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
