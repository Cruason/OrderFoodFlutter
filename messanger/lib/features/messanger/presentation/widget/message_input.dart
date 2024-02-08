import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

class MessageInput extends StatefulWidget {
  final Function(String) sendMessage;

  const MessageInput({super.key, required this.sendMessage});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  TextEditingController messageEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 14, top: 4),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color(0XFFEDF2F6),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: IconButton(
                onPressed: () {},
                icon: const ImageIcon(AssetImage(CustomIcons.upload))),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0XFFEDF2F6),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: TextField(
                decoration:  InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  hintText: "Сообщение",
                  border: InputBorder.none,
                  hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.lightGray)
                ),
                controller: messageEditingController,
                onChanged: (val) {
                  setState(() {
                    messageEditingController.text = val;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
              decoration: const BoxDecoration(
                  color: Color(0XFFEDF2F6),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: IconButton(
                  onPressed: () {
                    widget.sendMessage(messageEditingController.text);
                    messageEditingController.clear();
                  },
                  icon: ImageIcon(AssetImage(
                      (messageEditingController.text.isEmpty)
                          ? CustomIcons.micro
                          : CustomIcons.arrowUp))))
        ],
      ),
    );
  }
}
