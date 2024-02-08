import 'package:floor/floor.dart';
import 'package:messanger/features/messanger/data/model/chat_model.dart';

@dao
abstract class ChatDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertChat(ChatModel chatModel);

  @Query("Select * FROM chats WHERE first_user_id = :userId OR second_user_id = :userId")
  Future<List<ChatModel>> getChatsByUser(int userId);

  @Query("Select * FROM chats WHERE id = :id")
  Future<ChatModel?> getChatById(int id);
}