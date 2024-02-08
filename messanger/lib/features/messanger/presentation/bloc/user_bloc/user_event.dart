import 'package:messanger/features/messanger/domain/entity/user_entity.dart';

abstract class UserEvent{

}

class RegisterUserEvent extends UserEvent{
  final UserEntity userEntity;
   RegisterUserEvent(this.userEntity);
}

class LoginUserEvent extends UserEvent{
  final String phone;
  LoginUserEvent(this.phone);
}


class LogoutUserEvent extends UserEvent{
  LogoutUserEvent();
}