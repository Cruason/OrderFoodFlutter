import 'package:flutter/material.dart';
import 'package:messanger/features/messanger/domain/entity/message_entity.dart';
import 'package:messanger/features/messanger/presentation/widget/date_divider.dart';
import 'package:messanger/features/messanger/presentation/widget/message_card.dart';

class MessageList extends StatelessWidget {
  final int userId;
  final List<MessageEntity> messageList;

  const MessageList(
      {super.key, required this.messageList, required this.userId});

  @override
  Widget build(BuildContext context) {
    final reversed = messageList.reversed.toList();
    return ListView.builder(
      reverse: true,
      itemCount: reversed.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            (index == reversed.length - 1)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: DateDivider(
                        date: calcDate(
                            reversed[index].timeStamp, DateTime.now())),
                  )
                : (dayPassed(reversed[index].timeStamp,
                        reversed[index + 1].timeStamp))
                    ? DateDivider(
                        date:
                            calcDate(reversed[index].timeStamp, reversed[index+1].timeStamp))
                    : const SizedBox(),
            MessageCard(messageEntity: reversed[index], userId: userId)
          ],
        );
      },
    );
  }

  String calcDate(DateTime? receivedTime, DateTime? prevDime) {
    if (receivedTime != null && prevDime != null) {
      Duration difference = prevDime.difference(receivedTime);

      int days = difference.inDays;

      if (days > 1) {
        return "${receivedTime.year}.${receivedTime.month}.${receivedTime.day}";
      } else if (days == 1) {
        return "Вчера";
      }
    }
    return "Сегодня";
  }

  bool dayPassed(DateTime? receivedTime, DateTime? prevDime) {
    if (receivedTime != null && prevDime != null) {
      Duration difference = prevDime.difference(receivedTime);

      int days = difference.inDays;
      if (days > 1) {
        return true;
      }
    }
    return false;
  }
}
