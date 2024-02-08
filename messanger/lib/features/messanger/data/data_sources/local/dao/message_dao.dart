
import 'package:floor/floor.dart';
import 'package:messanger/features/messanger/data/model/message_model.dart';

@dao
abstract class MessageDao{
  @Insert(onConflict:  OnConflictStrategy.replace)
  Future<int> insertMessage(MessageModel messageModel);

  @Query('SELECT * FROM messages WHERE chat_id = :chatId')
  Future<List<MessageModel>> getMessagesByChat(int chatId);

  @Query('SELECT * FROM messages WHERE id = :id')
  Future<MessageModel?> getMessageById(int id);
}