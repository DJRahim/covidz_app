import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatPage4 extends StatelessWidget {
  StatPage4({Key? key}) : super(key: key);
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
              () => SecondCard(
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
                                  const Text("Variable cible   :  "),
                                  DropdownButton(
                                    value: mainController.currentCompVar.value,
                                    items: mainController.compVariables
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeCompVariable(newValue);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("Critere   :  "),
                                  DropdownButton(
                                    value:
                                        mainController.currentCompValue.value,
                                    items: mainController.statValues
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController.changeCompValue(newValue);
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
                                  var res = await _client.getChartData(
                                    "stat_comp",
                                    {
                                      "var":
                                          mainController.currentCompVar.value,
                                      "val":
                                          mainController.currentCompValue.value,
                                    },
                                  );
                                  mainController.changeCompData(res);
                                },
                                child: const Text("Afficher"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SecondCard(
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 360,
                            width: 360,
                            child: SfCartesianChart(
                              series: <
                                  BoxAndWhiskerSeries<BoxPlotData, dynamic>>[
                                BoxAndWhiskerSeries<BoxPlotData, dynamic>(
                                  dataSource: mainController.compList2.value,
                                  xValueMapper: (BoxPlotData data, _) => data.x,
                                  yValueMapper: (BoxPlotData data, _) => data.y,
                                ),
                              ],
                              primaryXAxis: CategoryAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  labelIntersectAction:
                                      AxisLabelIntersectAction.rotate45),
                              primaryYAxis: NumericAxis(
                                  name: 'Age',
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(size: 0)),
                              title: ChartTitle(
                                  alignment: ChartAlignment.center,
                                  textStyle: const TextStyle(fontSize: 13),
                                  text: "Graphe des boxplots basé sur l'age"),
                            ),
                          ),
                          PieChart(
                            chartData: mainController.compList.value,
                            title: ChartTitle(
                              alignment: ChartAlignment.center,
                              textStyle: const TextStyle(fontSize: 13),
                              text:
                                  "Graphe circulaire représentant les données",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Obx(
            //   () => SecondCard(
            //     body: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: [
            //         SecondCard(
            //           body: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               const AutoSizeText(
            //                   "Fréquence de consommation de certains aliments"),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   const Text("Choisir un critere :  "),
            //                   DropdownButton(
            //                     value: mainController.currentCompValue2.value,
            //                     items: mainController.statValues
            //                         .map((String items) {
            //                       return DropdownMenuItem(
            //                         value: items,
            //                         child: Text(items),
            //                       );
            //                     }).toList(),
            //                     onChanged: (String? newValue) {
            //                       mainController.changeCompValue2(newValue);
            //                     },
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   ElevatedButton(
            //                     onPressed: () async {
            //                       var res = await _client
            //                           .getChartDataComp("stat_comp2", {
            //                         "val":
            //                             mainController.currentCompValue2.value,
            //                       });
            //                       mainController.changeHeatMapComp(res);
            //                     },
            //                     child: const Text("Afficher"),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         SecondCard(
            //           body: SizedBox(
            //             width: 300.0,
            //             height: 400.0,
            //             child: Heatmap(
            //               heatmapData: mainController.heatmapDataComp.value,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
