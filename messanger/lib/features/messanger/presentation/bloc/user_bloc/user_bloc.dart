import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/resource/DataState.dart';
import 'package:messanger/features/messanger/domain/entity/user_entity.dart';
import 'package:messanger/features/messanger/domain/usecase/login_user_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/register_user_usecase.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_event.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUserUseCase loginUserUseCase;
  final RegisterUserUseCase registerUserUseCase;
  UserEntity userEntity = UserEntity();

  UserBloc(this.loginUserUseCase, this.registerUserUseCase)
      : super(UserDidNotLoginState()) {
    on<RegisterUserEvent>(onRegisterUser);
    on<LoginUserEvent>(onLoginUser);
    on<LogoutUserEvent>(onLogoutUser);
  }

  Future<void> onRegisterUser(RegisterUserEvent event, Emitter emitter) async {
    emitter(UserDidNotLoginState());
    final result = await registerUserUseCase
        .execute(event.userEntity);
    if (result is DataSuccess) {
      if (result.data != null) {
        userEntity = result.data!;
        emitter(UserSuccessState(result.data!));
      } else {
        emitter(UserDidNotLoginState());
      }
    } else if (result is DataError) {
      emitter(UserErrorState(result.message ?? "Unknown error"));
    }
  }

  Future<void> onLoginUser(LoginUserEvent event, Emitter emitter) async {
    emitter(UserDidNotLoginState());
    final result = await loginUserUseCase.execute(event.phone ?? "");
    if (result is DataSuccess) {
      if (result.data?.id != null) {
        userEntity = result.data!;
        emitter(UserSuccessState(result.data!));
      } else {
        emitter(UserDoesNotExistState("Пользователя с таким номером не существует"));
      }
    } else if (result is DataError) {
      emitter(UserErrorState(result.message ?? "Unknown error"));
    }
  }

  Future<void> onLogoutUser(LogoutUserEvent event, Emitter emitter) async{
    emitter(UserDidNotLoginState());
  }
}
