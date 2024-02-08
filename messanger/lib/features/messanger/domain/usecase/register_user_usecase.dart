import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';

class RegisterUserUseCase {
  final MessageRepository messageRepository;

  RegisterUserUseCase({required this.messageRepository});

  Future<DataState<UserEntity?>> execute(UserEntity userEntity) async {
    return await messageRepository.registerUser(userEntity);
  }
}
