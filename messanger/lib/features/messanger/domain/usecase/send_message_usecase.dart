import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase({required this.messageRepository});

  Future<DataState<void>> execute(
      int? chatId, MessageEntity messageEntity) async {
    return messageRepository.addMessage(chatId, messageEntity);
  }
}
