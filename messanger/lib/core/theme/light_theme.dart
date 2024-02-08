import 'package:flutter/material.dart';
import 'package:messanger/core/constants/constants.dart';

ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: CustomColors.black2B333E,
            fontFamily: 'Gilroy'),
        titleMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: CustomColors.black,
            fontFamily: 'Gilroy'),
        titleSmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: CustomColors.black2B333E,
            fontFamily: 'Gilroy'),
        bodyMedium: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
        bodySmall: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Gilroy')));
