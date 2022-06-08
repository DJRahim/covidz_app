import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
            Obx(
              () => MainCard(
                ontap: (vis) {
                  mainController.statVisibleFunc1(vis);
                },
                vis: mainController.statVisible1.value,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("variable :  "),
                                  DropdownButton(
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
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("valeur :  "),
                                  DropdownButton(
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
                                    "var": mainController
                                        .currentStatVariable.value,
                                    "val":
                                        mainController.currentStatvalue.value,
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
                      body: PieChart(
                        chartData: mainController.statList1.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => MainCard(
                ontap: (vis) {
                  mainController.statVisibleFunc2(vis);
                },
                vis: mainController.statVisible2.value,
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
                              DropdownButton(
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  var res = await _client
                                      .getChartData("chronic_stat", {
                                    "val": mainController
                                        .currentChronicValue.value,
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
                      body: PieChart(
                        chartData: mainController.statList2.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => MainCard(
                ontap: (vis) {
                  mainController.statVisibleFunc3(vis);
                },
                vis: mainController.statVisible3.value,
                title: "Les facteurs les plus pertinents",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("Choisir une methode :  "),
                                  DropdownButton(
                                    value: mainController
                                        .currentFeatureMethode.value,
                                    items: mainController
                                        .featureSelectionMethods
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeFeatureSelection(newValue);
                                      // API Call
                                      // Change table
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                      "Donner le nombre de facteurs :  "),
                                  SizedBox(
                                    width: 50.0,
                                    height: 10.0,
                                    child: TextField(
                                      controller:
                                          mainController.textFieldController8,
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Choisir la variable cible :  "),
                              DropdownButton(
                                value:
                                    mainController.currentVariableCible.value,
                                items: mainController.variableCibleList
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  mainController.changeVariableCible(newValue);
                                  // API Call
                                  // Change table
                                },
                              ),
                            ],
                          ),
                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.snackbar(
                                    "Chargement",
                                    "requête en cours de traitement",
                                    showProgressIndicator: true,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: false,
                                    duration: const Duration(hours: 1),
                                  );
                                  var res = await _client.getChartData(
                                    "feature_selection",
                                    {
                                      "method": mainController
                                          .currentFeatureMethode.value,
                                      "num_features": mainController
                                          .textFieldController8.text,
                                      "variable": mainController
                                          .currentVariableCible.value,
                                    },
                                  );
                                  Get.closeAllSnackbars();
                                  mainController.changeFeatureList(res);
                                },
                                child: const Text("Afficher"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SecondCard(
                      body: SizedBox(
                        height: double.parse(
                                mainController.textFieldController8.text) *
                            20,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            labelAlignment: LabelAlignment.center,
                          ),
                          series: <ChartSeries<ChartData, String>>[
                            BarSeries<ChartData, String>(
                              dataSource: mainController.featuresList.value,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              name: 'Gold',
                              color: const Color.fromRGBO(8, 142, 255, 1),
                            ),
                          ],
                        ),
                      ),
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
