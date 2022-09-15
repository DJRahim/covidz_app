import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/dataset_source.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/dataset_table.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PredictPage2 extends StatelessWidget {
  PredictPage2({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              SecondCard(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondCard(
                      body: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      "Dataset d'entraînement : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DropdownButton(
                                    value: mainController
                                        .predictTrainDataset.value,
                                    items: mainController.predictDatasets
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeTrainDataset(newValue);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      "Dataset de prediction : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DropdownButton(
                                    value:
                                        mainController.predictTestDataset.value,
                                    items: mainController.predictDatasets
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeTestDataset(newValue);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                      "Modele de prediction : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DropdownButton(
                                    value: mainController
                                        .currentPredictModel.value,
                                    items: mainController.predictModels
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changePredictModel(newValue);
                                      mainController
                                          .changePredictModelClass(newValue);
                                    },
                                  ),
                                ],
                              ),
                              AutoSizeText(
                                  "        (${mainController.currentPredictModelClass.value})"),
                            ],
                          ),
                          Visibility(
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                onPressed: () {
                                  mainController.changeSettingsPredict(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.arrow_right),
                                    AutoSizeText("Parametres"),
                                  ],
                                ),
                              ),
                            ),
                            visible: mainController.settingsPredict.value,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      mainController
                                          .changeSettingsPredict(false);
                                    },
                                    child: Row(
                                      children: const <Widget>[
                                        Icon(Icons.arrow_drop_down),
                                        AutoSizeText("Parametres"),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        100, 5, 100, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                controller: mainController
                                                    .textFieldController9,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                controller: mainController
                                                    .textFieldController10,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                  "Methode de la selection des facteurs pertinents :  "),
                                            ),
                                            DropdownButton(
                                              value: mainController
                                                  .predictFeatureSelect.value,
                                              items: mainController
                                                  .predictfeatureSelectionMethods
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
                                                    .changePredictFeatureSelect(
                                                        newValue);
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                controller: mainController
                                                    .textFieldController12,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                groupValue: mainController
                                                    .standar.value,
                                                onChanged: (val) {
                                                  mainController
                                                      .changeStandar(val);
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
                                                groupValue: mainController
                                                    .standar.value,
                                                onChanged: (val) {
                                                  mainController
                                                      .changeStandar(val);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 60),
                                            Visibility(
                                              visible: mainController
                                                      .standar.value ==
                                                  "Normalisation",
                                              replacement: const Text(""),
                                              child: ToggleSwitch(
                                                minWidth: 160,
                                                initialLabelIndex: 0,
                                                totalSwitches: 2,
                                                labels: const [
                                                  'Horizontalle (par ligne)',
                                                  'Verticalle (par colonne)'
                                                ],
                                                fontSize: 13,
                                                onToggle: (index) {
                                                  mainController
                                                      .changeNorm(index);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                              await getPredictions(context);
                              mainController.changePredictResult(true);
                              mainController.changePredictPerformance(true);
                              mainController.changeSettingsPredict(false);
                              Get.closeAllSnackbars();
                            },
                            child: const Text("Executer"),
                          ),
                          Visibility(
                            visible: mainController.predictPerformance.value,
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextButton(
                                onPressed: () {
                                  mainController.changePredictPerformance(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    AutoSizeText(
                                      "  Performances",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SecondCard(
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          mainController
                                              .changePredictPerformance(false);
                                        },
                                        child: Row(
                                          children: const <Widget>[
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            AutoSizeText(
                                              "  Performances",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              const AutoSizeText(
                                                "Performances du modele de prediction",
                                                maxFontSize: 14,
                                              ),
                                              SfCartesianChart(
                                                primaryXAxis: CategoryAxis(),
                                                primaryYAxis: NumericAxis(
                                                    minimum: 0,
                                                    maximum: 1,
                                                    interval: 0.1),
                                                series: <
                                                    ChartSeries<ChartData,
                                                        String>>[
                                                  ColumnSeries<ChartData,
                                                          String>(
                                                      dataSource: mainController
                                                          .performances.value,
                                                      xValueMapper:
                                                          (ChartData data, _) =>
                                                              data.x,
                                                      yValueMapper:
                                                          (ChartData data, _) =>
                                                              data.y,
                                                      name: 'Gold',
                                                      color:
                                                          const Color.fromRGBO(
                                                              8, 142, 255, 1))
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const AutoSizeText(
                                                "                                       Matrice de confucion des resultats de prediction",
                                                maxFontSize: 14,
                                              ),
                                              SizedBox(
                                                width: 480.0,
                                                height: 300.0,
                                                child: Heatmap(
                                                    heatmapData: mainController
                                                        .heatmapData.value),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: mainController.predictResult.value,
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextButton(
                                onPressed: () {
                                  mainController.changePredictResult(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    AutoSizeText(
                                      "  liste de résultats",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SecondCard(
                                  body: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          mainController
                                              .changePredictResult(false);
                                        },
                                        child: Row(
                                          children: const <Widget>[
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            AutoSizeText(
                                              "  liste de résultats",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const AutoSizeText(
                                              "  Les valeurs a afficher : "),
                                          SizedBox(
                                            height: 50,
                                            width: 205,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox1.value,
                                              title: const AutoSizeText(
                                                "few_to_no_symptoms",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 0);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 185,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox2.value,
                                              title: const AutoSizeText(
                                                "few_complications",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 1);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 180,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox3.value,
                                              title: const AutoSizeText(
                                                "critical_case",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 2);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 700,
                                        child: SecondCard(
                                          body: DatasetTable(
                                            headers: mainController
                                                .predictHeaders.value,
                                            source: DatasetSource(
                                                mainController, true),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: mainController.predictResult2.value,
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextButton(
                                onPressed: () {
                                  mainController.changePredictResult2(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    AutoSizeText(
                                      "  statistiques",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SecondCard(
                                  body: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          mainController
                                              .changePredictResult2(false);
                                        },
                                        child: Row(
                                          children: const <Widget>[
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            AutoSizeText(
                                              "  statistiques",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text("Variable cible :  "),
                                              DropdownButton(
                                                value: mainController
                                                    .currentPredictStat.value,
                                                items: mainController
                                                    .predictStatsList
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
                                                      .changePredictStatVariable(
                                                          newValue);
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                  "Valeur de prediction  :  "),
                                              DropdownButton(
                                                value: mainController
                                                    .currentPredictionVariable
                                                    .value,
                                                items: mainController
                                                    .predictionList
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
                                                      .changePredictionVariable(
                                                          newValue);
                                                },
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              var res =
                                                  await _client.getChartData(
                                                "predict_stat",
                                                {
                                                  "var": mainController
                                                      .currentPredictStat.value,
                                                  "predict_value": mainController
                                                      .currentPredictionVariable
                                                      .value,
                                                  "headers": mainController
                                                      .predictHeadersOld.value,
                                                  "rows": mainController
                                                      .predictRowsOld.value,
                                                },
                                              );
                                              mainController
                                                  .changePredcitData3(res);

                                              mainController
                                                  .updateCorrChronicDataPredict(
                                                      res[2]);
                                            },
                                            child: const Text("Afficher"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 360,
                                            width: 360,
                                            child: SfCartesianChart(
                                              series: <
                                                  BoxAndWhiskerSeries<
                                                      BoxPlotData, dynamic>>[
                                                BoxAndWhiskerSeries<BoxPlotData,
                                                    dynamic>(
                                                  dataSource: mainController
                                                      .predictStatList1_2.value,
                                                  xValueMapper:
                                                      (BoxPlotData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (BoxPlotData data, _) =>
                                                          data.y,
                                                ),
                                              ],
                                              primaryXAxis: CategoryAxis(
                                                  majorGridLines:
                                                      const MajorGridLines(
                                                          width: 0),
                                                  labelIntersectAction:
                                                      AxisLabelIntersectAction
                                                          .rotate45),
                                              primaryYAxis: NumericAxis(
                                                  name: 'Age',
                                                  axisLine:
                                                      const AxisLine(width: 0),
                                                  majorTickLines:
                                                      const MajorTickLines(
                                                          size: 0)),
                                              title: ChartTitle(
                                                alignment:
                                                    ChartAlignment.center,
                                                textStyle: const TextStyle(
                                                    fontSize: 13),
                                                text:
                                                    "Graphe des boxplots basé sur l'age",
                                              ),
                                            ),
                                          ),
                                          PieChart(
                                            chartData: mainController
                                                .predictList3.value,
                                            title: ChartTitle(
                                              textStyle:
                                                  const TextStyle(fontSize: 13),
                                              text:
                                                  "Graphe circulaire représentant les données",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SecondCard(
                                  body: Column(
                                    children: [
                                      const AutoSizeText(
                                        "Graphe de la correlation entre les maladies chroniques et l'evolution des cas predis",
                                        maxFontSize: 14,
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: 400,
                                        child: SfCartesianChart(
                                          legend: Legend(
                                            isVisible: true,
                                          ),
                                          primaryXAxis: CategoryAxis(
                                            labelRotation: 70,
                                            labelAlignment: LabelAlignment.end,
                                          ),
                                          series: mainController
                                              .corrChronicDataPredict.value,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPredictions(BuildContext context) async {
    var res = await _client.getPredictRowsHeaders(
      "predict",
      {
        "model": mainController.currentPredictModel.value,
        "feature_model": mainController.predictFeatureSelect.value,
        "num_features": mainController.textFieldController12.text,
        "null_percentage": mainController.textFieldController9.text,
        "test_percentage": mainController.textFieldController10.text,
        "standarisation": mainController.standar.value == "Standarisation",
        "normalisation": mainController.standar.value != "Standarisation",
        "axis": mainController.normToggle.value,
        "train_dataset": mainController.predictTrainDataset.value,
        "test_dataset": mainController.predictTestDataset.value,
      },
      mainController,
      context,
    );

    mainController.changePredictList(true, 0);
    mainController.changePredictList(true, 1);
    mainController.changePredictList(true, 2);

    mainController.setMinWidth(18000.0);
    mainController.setPredictRowsAndHeaders(res[0], res[1]);

    mainController.changeHeatMap(res[2][0]);
    mainController.changePerformances(res[2][1]);
  }
}
