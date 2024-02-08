import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class UserExistUseCase {
  final MessageRepository messageRepository;

  UserExistUseCase({required this.messageRepository});

  Future<DataState<int?>> execute(String phone) async {
    return await messageRepository.userExist(phone);
  }
}