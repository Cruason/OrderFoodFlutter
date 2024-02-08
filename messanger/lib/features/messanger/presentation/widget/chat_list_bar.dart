import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

class ChatListBar extends StatelessWidget {
  final Function() startChat;
  final Function() logout;

  const ChatListBar({super.key, required this.startChat, required this.logout});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Column(
      children: [
        Row(
          children: [
            Text("Чаты", style: Theme.of(context).textTheme.titleLarge),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () {
                startChat();
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
            const SizedBox(width: 10,),
            IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.logout_sharp,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color(0XFFEDF2F6),
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15, bottom: 10),
              prefixIcon: const ImageIcon(
                AssetImage(CustomIcons.search),
                size: 20,
                color: CustomColors.lightGray,
              ),
              border: InputBorder.none,
              hintText: "Поиск",
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: CustomColors.lightGray, fontWeight: FontWeight.w500),
            ),
            controller: searchController,
            onChanged: (val) {},
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: CustomColors.lightGray, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
