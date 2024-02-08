import 'package:messanger/features/messanger/domain/entity/user_entity.dart';

abstract class UserState{
  final String? message;

  UserState({this.message});
}

class UserSuccessState extends UserState{
  final UserEntity userEntity;

  UserSuccessState(this.userEntity);
}

class UserErrorState extends UserState{
  UserErrorState(String error): super(message: error);
}


class UserDidNotLoginState extends UserState{
  UserDidNotLoginState();
}

class UserDoesNotExistState extends UserState{
  UserDoesNotExistState(String message): super(message: message);
}