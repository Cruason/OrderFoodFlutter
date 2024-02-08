import 'package:floor/floor.dart';
import 'package:messanger/core/constants/constants.dart';

@Entity(tableName: "chats")
class ChatModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: "first_user_id")
  final int? firstUserId;
  @ColumnInfo(name: "second_user_id")
  final int? secondUserId;
  @ColumnInfo(name: "last_message_id")
  final int? lastMessageId;
  @ColumnInfo(name: "color")
  final ProfileColor? color;

  ChatModel({this.id, this.firstUserId, this.secondUserId, this.lastMessageId, this.color });

  ChatModel copyWith(
      {int? id, int? firstUserId, int? secondUserId, int? lastMessageId, ProfileColor? color}){
    return ChatModel(
      id: id?? this.id,
      firstUserId: firstUserId??this.firstUserId,
      secondUserId: secondUserId??this.secondUserId,
      lastMessageId: lastMessageId??this.lastMessageId,
      color: color??this.color
    );
  }
}