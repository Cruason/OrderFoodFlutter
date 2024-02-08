import 'package:flutter/material.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';
import 'package:messanger/features/messanger/presentation/widget/chat_card.dart';

class ChatList extends StatelessWidget {
  final List<ChatEntity> chatList;
  final int userId;
  final Function(ChatEntity) onClick;

  const ChatList({super.key, required this.chatList, required this.userId, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                onClick(chatList[index]);
              },
              child: ChatCard(
                chatEntity: chatList[index],
                userId: userId,
              ));
        });
  }
}
