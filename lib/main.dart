import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/pages/auth_page.dart';
import 'package:covidz/pages/dataset_page.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/pages/predict_page.dart';
import 'package:covidz/pages/settings_page.dart';
import 'package:covidz/pages/stat_page.dart';
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
      home: AnimatedSplashScreen(
        nextScreen: AuthPage(),
        splash: const Text(
          'COVIDZ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
            color: Color.fromARGB(255, 17, 70, 105),
          ),
        ),
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(milliseconds: 1500),
        duration: 2000,
        backgroundColor: Colors.white,
      ),
    );
  }
}
