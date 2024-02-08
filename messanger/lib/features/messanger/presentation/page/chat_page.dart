import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:messanger/features/messanger/presentation/bloc/chat_bloc/chat_state.dart';
import 'package:messanger/features/messanger/presentation/widget/chat_bar.dart';
import 'package:messanger/features/messanger/presentation/widget/message_input.dart';
import 'package:messanger/features/messanger/presentation/widget/message_list.dart';

class ChatPage extends StatelessWidget {
  final int userId;
  final ChatBloc chatBloc;
  final ChatEntity chatEntity;

  const ChatPage(
      {super.key,
      required this.chatBloc,
      required this.chatEntity,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height + 12),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChatBar(
                chatName: chatEntity.chatName,
                color: chatEntity.color, goBack: () {
                    Navigator.pop(context);
              },
              ),
            ),
          ),
        ),
        body: BlocProvider(
            create: (context) => chatBloc,
            child: BlocBuilder(
                bloc: chatBloc..add(GetMessagesEvent(chatEntity.id!, userId)),
                builder: (context, state) {
                  return Column(
                    children: [
                      const Divider(
                        thickness: 1,
                        color: CustomColors.lightDivider,
                      ),
                      (state is MessagesSuccessState)
                          ? Expanded(
                              child:
                                  MessageList(messageList: state.messageList, userId: userId))
                          : const SizedBox(),
                      const Divider(
                        thickness: 1,
                        color: CustomColors.lightDivider,
                      ),
                      MessageInput(
                        sendMessage: (message) {
                          chatBloc.add(SendMessageEvent(
                              userId: userId,
                              message: message,
                              chatId: chatEntity.id!));
                        },
                      ),
                    ],
                  );
                })));
  }
}
