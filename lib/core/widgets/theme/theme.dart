import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
// inputDecorationTheme: TTextFormFiled.lightInputDecorationTheme,
  fontFamily: 'PlayfairDisplay',
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: Colors.grey[700],
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
);
ThemeData themeArabic = ThemeData(
  fontFamily: 'Cairo',
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: Colors.grey[700],
      height: 2,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
);
