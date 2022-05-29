import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
            Obx(
              () => MainCard(
                ontap: (vis) {
                  mainController.settingsVisibleFunc1(vis);
                },
                vis: mainController.settingsVisible1.value,
                title: "Parametres du pre-traitement",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                            "Pourcentage des valeurs non-nulles dans chaque colonne (les autres seront ignores):       "),
                        SizedBox(
                          width: 50.0,
                          height: 10.0,
                          child: TextField(
                            controller: mainController.textFieldController9,
                            // decoration: const InputDecoration(
                            //     labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                            "Pourcentage de l'ensemble de test :     "),
                        SizedBox(
                          width: 50.0,
                          height: 10.0,
                          child: TextField(
                            controller: mainController.textFieldController10,
                            // decoration: const InputDecoration(
                            //     labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Standarisation : "),
                        SizedBox(
                          width: 200,
                          child: RadioListTile(
                            title: const Text("Oui"),
                            value: "yes",
                            groupValue: mainController.standar.value,
                            onChanged: (val) {
                              mainController.changeStandar(val);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: RadioListTile(
                            title: const Text("Non"),
                            value: "no",
                            groupValue: mainController.standar.value,
                            onChanged: (val) {
                              mainController.changeStandar(val);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Normalisation : "),
                        TextButton(
                          onPressed: () {
                            if (mainController.normalList2
                                .contains("Horizontal")) {
                              mainController.removeFromNormalList("Horizontal");
                            } else {
                              mainController.addToNormalList("Horizontal");
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: mainController.normalList2
                                    .contains("Horizontal")
                                ? Colors.cyanAccent[700]
                                : Colors.grey[600],
                          ),
                          child: const Text("Horizontal (par ligne)"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (mainController.normalList2
                                .contains("Vertical")) {
                              mainController.removeFromNormalList("Vertical");
                            } else {
                              mainController.addToNormalList("Vertical");
                            }
                          },
                          style: TextButton.styleFrom(
                            primary: Theme.of(context).colorScheme.onPrimary,
                            backgroundColor: mainController.normalList2
                                    .contains("Vertical")
                                ? Colors.cyanAccent[700]
                                : Colors.grey[600],
                          ),
                          child: const Text("Vertical (par colonne)"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
