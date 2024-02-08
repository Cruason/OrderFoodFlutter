import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class LoginUserUseCase {
  final MessageRepository messageRepository;

  LoginUserUseCase({required this.messageRepository});

  Future<DataState<UserEntity?>> execute(String phone) async {
    return await messageRepository.loginUser(phone);
  }
}