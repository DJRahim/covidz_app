import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/pages/dataset_page.dart';
import 'package:covidz/pages/predict_page1.dart';
import 'package:covidz/pages/settings_page.dart';
import 'package:covidz/pages/stat_page1.dart';
import 'package:covidz/tools/app_theme.dart';
import 'package:covidz/tools/auth.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Home extends GetView<MainController> {
  Home({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  final List<Widget> views = [
    DatasetPage(),
    StatPage1(),
    PredictPage1(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              controller.changeSideMenuDisplay();
            },
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              // page controller to manage a PageView
              controller: controller.page,
              // List of SideMenuItem to show them on SideMenu
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Datasets',
                  onTap: () => controller.page.jumpToPage(0),
                  icon: const Icon(Icons.data_array),
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Statistiques',
                  onTap: () => controller.page.jumpToPage(1),
                  icon: const Icon(Icons.bar_chart),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Prediction',
                  onTap: () => controller.page.jumpToPage(2),
                  icon: const Icon(Icons.area_chart),
                ),
              ],
              style: SideMenuStyle(
                displayMode: controller.sideMenuDisplay.value,
                openSideMenuWidth: 230,
                hoverColor: Theme.of(context).hoverColor,
                selectedColor: Theme.of(context).selectedRowColor,
                selectedTitleTextStyle:
                    Theme.of(context).appBarTheme.titleTextStyle,
                selectedIconColor:
                    Theme.of(context).appBarTheme.foregroundColor,
                unselectedIconColor:
                    Theme.of(context).appBarTheme.foregroundColor,
                unselectedTitleTextStyle:
                    Theme.of(context).appBarTheme.titleTextStyle,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 79, 117, 134),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                // openSideMenuWidth: 200
              ),
              footer: SideMenuItem(
                priority: 3,
                title: 'Parametres',
                onTap: () => controller.page.jumpToPage(3),
                icon: const Icon(Icons.settings),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.page,
                children: views,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
