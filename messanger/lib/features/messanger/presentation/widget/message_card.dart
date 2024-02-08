import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';

class MessageCard extends StatelessWidget {
  final int userId;
  final MessageEntity messageEntity;

  const MessageCard(
      {super.key, required this.messageEntity, required this.userId});

  @override
  Widget build(BuildContext context) {
    final hour = (messageEntity.timeStamp!.hour < 10)? "0${messageEntity.timeStamp!.hour}" : messageEntity.timeStamp!.hour.toString();
    final minute = (messageEntity.timeStamp!.minute < 10)? "0${messageEntity.timeStamp!.minute}" : messageEntity.timeStamp!.minute.toString();
    return Align(
      alignment: (messageEntity.senderId == userId)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: FittedBox(
          fit: BoxFit.none,
          child: Container(
              decoration: BoxDecoration(
                color: (messageEntity.senderId == userId)
                    ? CustomColors.lightGreen
                    : const Color(0XFFEDF2F6),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  bottomLeft: (messageEntity.senderId == userId)
                      ? const Radius.circular(15)
                      : Radius.zero,
                  bottomRight: (messageEntity.senderId != userId)
                      ? const Radius.circular(15)
                      : Radius.zero,
                  topRight: const Radius.circular(15),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        messageEntity.message ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: (messageEntity.senderId == userId)
                                ? CustomColors.darkGreen
                                : CustomColors.black2B333E),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$hour:$minute",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: (messageEntity.senderId == userId)
                              ? CustomColors.darkGreen
                              : CustomColors.black2B333E),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    messageEntity.senderId == userId
                        ? ImageIcon(
                            AssetImage((messageEntity.isRed)
                                ? CustomIcons.read
                                : CustomIcons.unread),
                            size: 12,
                          )
                        : const SizedBox()
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
