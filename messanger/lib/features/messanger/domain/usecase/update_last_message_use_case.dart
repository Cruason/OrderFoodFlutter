import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class UpdateLastMessageUseCase {
  final MessageRepository messageRepository;

  UpdateLastMessageUseCase({required this.messageRepository});

  Future<DataState<void>> execute(int chatId, int messageId)async{
    return await messageRepository.addLastMessage(chatId, messageId);
  }
}