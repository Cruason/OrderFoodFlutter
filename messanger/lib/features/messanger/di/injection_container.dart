import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:messanger/features/messanger/data/data_sources/local/app_database.dart';
import 'package:messanger/features/messanger/data/repository/message_repository_impl.dart';
import 'package:messanger/features/messanger/domain/repository/message_repository.dart';
import 'package:messanger/features/messanger/domain/usecase/add_chat_usercase.dart';
import 'package:messanger/features/messanger/domain/usecase/get_chat_list_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/get_message_list_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/login_user_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/register_user_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/send_message_usecase.dart';
import 'package:messanger/features/messanger/domain/usecase/update_last_message_use_case.dart';
import 'package:messanger/features/messanger/domain/usecase/user_exist_usecase.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:messanger/features/messanger/presentation/bloc/user_bloc/user_bloc.dart';

final di = GetIt.instance;

Future<void> initializeDependencies() async{
    // final appDatabase=await $FloorAppDataBase.databaseBuilder("app_database.db").build();
    //
    // await appDatabase.close();
    // await File(appDatabase.database.database.path).delete();


    final database = await $FloorAppDataBase
        .databaseBuilder('app_database.db')
        .build();
    // database.database.delete("chats");
    // database.database.delete("users");
    // database.database.delete("messages");

  di.registerSingleton<AppDataBase>(database);
  di.registerSingleton<MessageRepository>(MessageRepositoryImpl(appDataBase: di()));

  di.registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(messageRepository: di()));
  di.registerSingleton<LoginUserUseCase>(LoginUserUseCase(messageRepository: di()));
  di.registerSingleton<UserExistUseCase>(UserExistUseCase(messageRepository: di()));
  di.registerSingleton<AddChatUseCase>(AddChatUseCase(messageRepository: di()));
  di.registerSingleton<GetChatListUseCase>(GetChatListUseCase(messageRepository: di()));
  di.registerSingleton<GetMessageListUseCase>(GetMessageListUseCase(messageRepository: di()));
  di.registerSingleton<SendMessageUseCase>(SendMessageUseCase(messageRepository: di()));
  di.registerSingleton<UpdateLastMessageUseCase>(UpdateLastMessageUseCase(messageRepository: di()));

  di.registerFactory<UserBloc>(() => UserBloc(di(), di()));
  di.registerFactory<ChatBloc>(() => ChatBloc(di(),di(),di(), di(), di(), di()));

}