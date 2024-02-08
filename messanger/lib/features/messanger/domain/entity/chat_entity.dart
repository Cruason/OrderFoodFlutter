import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';

class ChatEntity {
  final int? id;
  final String? chatName;
  final MessageEntity? messageEntity;
  final ProfileColor? color;

  ChatEntity({this.id, this.chatName, this.messageEntity, this.color});
}
