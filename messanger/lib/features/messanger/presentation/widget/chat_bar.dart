import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

class ChatBar extends StatelessWidget {
  final String? chatName;
  final ProfileColor? color;
  final Function() goBack;

  const ChatBar(
      {super.key,
      required this.chatName,
      required this.color,
      required this.goBack});

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = const LinearGradient(colors: [
      CustomColors.orangeGradientStart,
      CustomColors.orangeGradientEnd
    ]);
    switch (color) {
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              goBack();
            },
            icon: const ImageIcon(
              AssetImage(CustomIcons.arrowLeft),
              size: 24,
              color: Colors.black,
            )),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
          ),
          child: Center(
            child: Text(getFirstLetters(chatName ?? ""),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatName ?? "",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "В сети",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: CustomColors.darkGray),
            )
          ],
        )
      ],
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
}
