import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MainCard(
              title: "Settings Page",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text("settings ..."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
