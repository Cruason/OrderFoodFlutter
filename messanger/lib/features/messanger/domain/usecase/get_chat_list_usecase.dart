import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class GetChatListUseCase {
  final MessageRepository messageRepository;

  GetChatListUseCase({required this.messageRepository});

  Future<DataState<List<ChatEntity>>> execute(int userId) async{
    return await messageRepository.getChats(userId);
  }
}