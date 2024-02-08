import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';
import 'package:messanger/features/messanger/domain/entity/chat_entity.dart';

class ChatCard extends StatelessWidget {
  final int userId;
  final ChatEntity chatEntity;

  const ChatCard({super.key, required this.chatEntity, required this.userId});

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(colors: [
      CustomColors.orangeGradientStart,
      CustomColors.orangeGradientEnd
    ]);
    switch (chatEntity.color) {
      case ProfileColor.orange:
        gradient = const LinearGradient(colors: [
          CustomColors.orangeGradientStart,
          CustomColors.orangeGradientEnd
        ]);
        break;
      case ProfileColor.green:
        gradient = const LinearGradient(colors: [
          CustomColors.greenGradientStart,
          CustomColors.greenGradientEnd
        ]);
        break;
      case ProfileColor.blue:
        gradient = const LinearGradient(colors: [
          CustomColors.blueGradientStart,
          CustomColors.blueGradientEnd
        ]);
        break;
      default:
        break;
    }
    return Column(
      children : [ Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient,
              ),
              child: Center(
                child: Text(getFirstLetters(chatEntity.chatName ?? ""),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, // Text color
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chatEntity.chatName ?? "",
                      style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    children: [
                      (chatEntity.messageEntity?.senderId == userId)
                          ? Text(
                              "Вы: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: CustomColors.black2B333E),
                            )
                          : const SizedBox(),
                      Text(
                        chatEntity.messageEntity?.message ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: CustomColors.darkGray),
                      )
                    ],
                  )
                ],
              ),
            )),
            Text(
              calcDate(chatEntity.messageEntity?.timeStamp),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: CustomColors.darkGray),
            ),
            const SizedBox(
              width: 12,
            )
          ],
        ),
      ),
        const Divider(
          thickness: 1,
          color: CustomColors.lightDivider,
        )
      ]
    );
  }

  String getFirstLetters(String input) {
    List<String> words = input.split(" ");
    List<String> firstLetters = words.map((word) {
      if (word.isNotEmpty) {
        return word[0];
      } else {
        return "";
      }
    }).toList();
    return firstLetters.join("");
  }

  String calcDate(DateTime? receivedTime) {
    DateTime currentDateTime = DateTime.now();

    if (receivedTime != null) {
      Duration difference = currentDateTime.difference(receivedTime);

      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;
      int days = difference.inDays;

      if (days > 1) {
        return "${receivedTime.year}.${receivedTime.month}.${receivedTime.day}";
      } else if (days == 1) {
        return "Вчера";
      } else if (hours < 1) {
        return "${minutes.toString()} минуты назад";
      } else if (hours > 1) {
        return "больше часа назад";
      }
    }
    return "";
  }
}
