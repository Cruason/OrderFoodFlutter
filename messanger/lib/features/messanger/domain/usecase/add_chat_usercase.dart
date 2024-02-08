import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class AddChatUseCase {
  final MessageRepository messageRepository;

  AddChatUseCase({required this.messageRepository});

  Future<DataState<void>> execute(ChatEntity chatEntity, int? firstUserId, int? secondUserId) async{
    return await messageRepository.addChat(chatEntity, firstUserId, secondUserId);
  }

}