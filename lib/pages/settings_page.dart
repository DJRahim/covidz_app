// ignore_for_file: invalid_use_of_protected_member

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: AutoSizeText(
                                "Pourcentage des valeurs non-nulles dans chaque colonne (les autres seront ignores):       "),
                          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: AutoSizeText(
                                "Pourcentage de l'ensemble de test :     "),
                          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: AutoSizeText(
                                "Methode de la selection des facteurs pertinents :  "),
                          ),
                          DropdownButton(
                            value: mainController.predictFeatureSelect.value,
                            items: mainController.predictfeatureSelectionMethods
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              mainController
                                  .changePredictFeatureSelect(newValue);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: AutoSizeText(
                                "Nombre de facteurs a selectionner :  "),
                          ),
                          SizedBox(
                            width: 50.0,
                            height: 10.0,
                            child: TextField(
                              controller: mainController.textFieldController12,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 180,
                            child: RadioListTile(
                              title: const Text(
                                "Standarisation",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              value: "Standarisation",
                              groupValue: mainController.standar.value,
                              onChanged: (val) {
                                mainController.changeStandar(val);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 180,
                            child: RadioListTile(
                              title: const Text(
                                "Normalisation",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              value: "Normalisation",
                              groupValue: mainController.standar.value,
                              onChanged: (val) {
                                mainController.changeStandar(val);
                              },
                            ),
                          ),
                          const SizedBox(width: 60),
                          Visibility(
                            visible:
                                mainController.standar.value == "Normalisation",
                            replacement: const Text(""),
                            child: ToggleSwitch(
                              minWidth: 100,
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              labels: const [
                                'Horizontalle (par ligne)',
                                'Verticalle (par colonne)'
                              ],
                              onToggle: (index) {
                                mainController.changeNorm(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
