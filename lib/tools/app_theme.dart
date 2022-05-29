import 'package:covidz/assets/color_constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.gunMetal,
      onPrimary: Colors.black,
      secondary: AppColors.spaceBlue,
      onSecondary: AppColors.grey,
      background: AppColors.baby,
      tertiary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.baby,
    selectedRowColor: Colors.blue[600],
    hoverColor: Colors.blue[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.gunMetal,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkmetal,
      onPrimary: Colors.white,
      secondary: AppColors.spaceBlue,
      onSecondary: AppColors.darkmetal,
      background: AppColors.darkGrey,
      tertiary: Color.fromARGB(255, 81, 95, 114),
    ),
    scaffoldBackgroundColor: AppColors.darkGrey,
    selectedRowColor: const Color.fromARGB(255, 17, 81, 136),
    hoverColor: const Color.fromARGB(255, 110, 133, 151),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkmetal,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: const CardTheme(
      color: AppColors.darkGrey,
    ),
  );
}
