import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/pages/dataset_page.dart';
import 'package:covidz/pages/predict_page1.dart';
import 'package:covidz/pages/predict_page2.dart';
import 'package:covidz/old/settings_page.dart';
import 'package:covidz/pages/stat_page1.dart';
import 'package:covidz/pages/stat_page2.dart';
import 'package:covidz/pages/stat_page3.dart';
import 'package:covidz/pages/stat_page4.dart';
import 'package:covidz/tools/app_theme.dart';
import 'package:covidz/tools/auth.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeNew extends GetView<MainController> {
  HomeNew({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  final List<Widget> views = [
    DatasetPage(),
    StatPage1(),
    StatPage2(),
    StatPage3(),
    StatPage4(),
    PredictPage1(),
    PredictPage2(),
    // SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {},
        ),
        title: Row(
          children: const [
            Text(
              "  COVI",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "DZ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            )
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                themeController.changeTheme(Themes.lightTheme);
                themeController.saveTheme(false);
              } else {
                themeController.changeTheme(Themes.darkTheme);
                themeController.saveTheme(true);
              }
            },
            icon: Get.isDarkMode
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
          IconButton(
            onPressed: () {
              authController.signOut();
              Get.put(AuthController());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      sideBar: SideBar(
        backgroundColor: Get.isDarkMode
            ? const Color.fromARGB(255, 16, 37, 51)
            : const Color.fromARGB(255, 130, 179, 202),
        activeBackgroundColor: Theme.of(context).selectedRowColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        activeTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconColor: Theme.of(context).appBarTheme.foregroundColor,
        activeIconColor: Theme.of(context).appBarTheme.foregroundColor,
        items: const [
          AdminMenuItem(
            title: 'Datasets',
            route: 'DatasetPage',
            icon: Icons.data_array,
          ),
          AdminMenuItem(
            title: 'Analyse reelle',
            icon: Icons.bar_chart,
            children: [
              AdminMenuItem(
                title: 'Statistiques generalles',
                route: 'StatPage1',
              ),
              AdminMenuItem(
                title: 'Maladies chroniques',
                route: 'StatPage2',
              ),
              AdminMenuItem(
                title: 'Selection des facteurs les plus pertinents',
                route: 'StatPage3',
              ),
              AdminMenuItem(
                title: 'Comportement',
                route: 'StatPage4',
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Analyse predictive',
            icon: Icons.area_chart,
            children: [
              AdminMenuItem(
                title: "Prevision du taux d'infectiuon",
                route: 'PredictPage1',
              ),
              AdminMenuItem(
                title: "Prediction de l'evolution des cas infectes",
                route: 'PredictPage2',
              ),
            ],
          ),
          // AdminMenuItem(
          //   title: 'Parametres',
          //   route: 'Settings',
          //   icon: Icons.settings,
          // ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            if (item.route == "DatasetPage") {
              controller.page.jumpToPage(0);
            }
            if (item.route == "StatPage1") {
              controller.page.jumpToPage(1);
            }
            if (item.route == "StatPage2") {
              controller.page.jumpToPage(2);
            }
            if (item.route == "StatPage3") {
              controller.page.jumpToPage(3);
            }
            if (item.route == "StatPage4") {
              controller.page.jumpToPage(4);
            }
            if (item.route == "PredictPage1") {
              controller.page.jumpToPage(5);
            }
            if (item.route == "PredictPage2") {
              controller.page.jumpToPage(6);
            }
            // if (item.route == "Settings") {
            //   controller.page.jumpToPage(7);
            // }
          }
        },
      ),
      body: Expanded(
        child: PageView(
          controller: controller.page,
          children: views,
        ),
      ),
    );
  }
}
