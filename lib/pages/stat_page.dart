import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatPage extends StatelessWidget {
  StatPage({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MainCard(
              title: "Statistiques generales",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecondCard(
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Choisir une variable :  "),
                                Obx(
                                  () => DropdownButton(
                                    value: mainController
                                        .currentStatVariable.value,
                                    items: mainController.statVariables
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeStatVariable(newValue);
                                      // API Call
                                      // Change table
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Choisir une valeur :  "),
                                Obx(
                                  () => DropdownButton(
                                    value:
                                        mainController.currentStatvalue.value,
                                    items: mainController.statValues
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController.changeStatValue(newValue);
                                      // API Call
                                      // Change table
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                var res =
                                    await _client.getChartData("first_stat", {
                                  "var":
                                      mainController.currentStatVariable.value,
                                  "val": mainController.currentStatvalue.value,
                                });
                                mainController.changeStatData1(res);
                              },
                              child: const Text("Afficher"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SecondCard(
                    body: Obx(
                      () => PieChart(
                        chartData: mainController.statList1.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MainCard(
              title: "Maladies chroniques",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecondCard(
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Choisir une variable :  "),
                            Obx(
                              () => DropdownButton(
                                value: mainController.currentChronicValue.value,
                                items: mainController.statValues
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  mainController.changeChronicValue(newValue);
                                  // API Call
                                  // Change table
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                var res =
                                    await _client.getChartData("chronic_stat", {
                                  "val":
                                      mainController.currentChronicValue.value,
                                });
                                mainController.changeStatData2(res);
                              },
                              child: const Text("Afficher"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SecondCard(
                    body: Obx(
                      () => PieChart(
                        chartData: mainController.statList2.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MainCard(
              title: "Les facteurs les plus pertinents",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text("feature selection ..."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
