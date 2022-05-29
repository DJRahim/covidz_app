import 'dart:io';

import 'package:covidz/pages/dataset_page.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/pages/predict_page.dart';
import 'package:covidz/pages/settings_page.dart';
import 'package:covidz/pages/stat_page.dart';
import 'package:covidz/tools/app_theme.dart';
import 'package:covidz/tools/custom_scroll_behaviour.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final themeController = Get.put(ThemeController());
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'COVIDZ',
      // initialBinding: AppBinding(),
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: themeController.theme,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
        ),
        GetPage(name: '/datasets_page', page: () => DatasetPage()),
        GetPage(name: '/stat_page', page: () => StatPage()),
        GetPage(name: '/predict_page', page: () => PredictPage()),
        GetPage(name: '/settings_page', page: () => SettingsPage()),
      ],
      home: Home(),
    );
  }
}
