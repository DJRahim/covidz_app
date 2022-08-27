import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/pages/admin_request_list.dart';
import 'package:covidz/pages/admin_user_list.dart';
import 'package:covidz/tools/app_theme.dart';
import 'package:covidz/tools/auth.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class HomeAdmin extends GetView<MainController> {
  HomeAdmin({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  final List<Widget> views = [
    AdminRequestList(),
    AdminUserList(),
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
        textStyle: (Theme.of(context).appBarTheme.titleTextStyle)!,
        activeTextStyle: (Theme.of(context).appBarTheme.titleTextStyle)!,
        iconColor: Theme.of(context).appBarTheme.foregroundColor,
        activeIconColor: Theme.of(context).appBarTheme.foregroundColor,
        items: const [
          AdminMenuItem(
            title: "Demandes d'inscription",
            route: 'admin_request_list',
            icon: Icons.verified_user,
          ),
          AdminMenuItem(
            title: 'Liste des utilisateurs',
            route: 'admin_user_list',
            icon: Icons.supervised_user_circle,
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            if (item.route == "admin_request_list") {
              controller.page.jumpToPage(0);
            }
            if (item.route == "admin_user_list") {
              controller.page.jumpToPage(1);
            }
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
