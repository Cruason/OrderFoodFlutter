
import 'package:floor/floor.dart';

@Entity(tableName: "messages")
class MessageModel{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: "chat_id")
  final int? chatId;
  @ColumnInfo(name: "sender_id")
  final int? senderId;
  final String? message;
  final int? timeStampMillis;
  final bool? isRed;

  MessageModel(
      {this.id,
      this.chatId,
      this.senderId,
      this.message,
      this.timeStampMillis,
      this.isRed});
}