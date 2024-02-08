import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class GetMessageListUseCase {
  final MessageRepository messageRepository;

  GetMessageListUseCase({required this.messageRepository});

  Future<DataState<List<MessageEntity>>> execute(int? chatId) async{
    return await messageRepository.getMessages(chatId);
  }
}