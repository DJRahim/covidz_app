import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/home_page_admin.dart';
import 'package:covidz/pages/auth_page.dart';
import 'package:covidz/pages/dataset_page.dart';
import 'package:covidz/pages/predict_page1.dart';
import 'package:covidz/old/settings_page.dart';
import 'package:covidz/pages/stat_page1.dart';
import 'package:covidz/tools/app_theme.dart';
import 'package:covidz/tools/auth.dart';
import 'package:covidz/tools/custom_scroll_behaviour.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final themeController = Get.put(ThemeController());
  final mainController = Get.put(MainController());
  final box = GetStorage();

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
          page: () => HomeNew(),
        ),
        GetPage(name: '/datasets_page', page: () => DatasetPage()),
        GetPage(name: '/stat_page', page: () => StatPage1()),
        GetPage(name: '/predict_page', page: () => PredictPage1()),
        GetPage(name: '/settings_page', page: () => SettingsPage()),
        GetPage(name: '/auth', page: () => AuthPage()),
        GetPage(
            name: "/home",
            page: () =>
                box.read("user_type") == "normal" ? HomeNew() : HomeAdmin())
      ],
      home: AuthPage(),
    );
  }
}
