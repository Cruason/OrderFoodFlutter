import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

class DateDivider extends StatelessWidget {
  final String date;
  const DateDivider({super.key, required this.date});


  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const Expanded(child: Divider(thickness: 1, color: CustomColors.lightGray,)),
        const SizedBox(width: 10,),
        Text(date, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.lightGray),),
        const SizedBox(width: 10,),
        const Expanded(child: Divider(thickness: 1, color: CustomColors.lightGray,)),
      ],
    );
  }
}
