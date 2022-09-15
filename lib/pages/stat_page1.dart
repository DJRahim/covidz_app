import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatPage1 extends StatelessWidget {
  StatPage1({Key? key}) : super(key: key);
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
                                  const Text(
                                    "Variable cible   :  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                                  const Text(
                                    "Critere   :  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
                                  dataSource: mainController.statList1_2.value,
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
                                text: "Graphe des boxplots basé sur l'age",
                              ),
                            ),
                          ),
                          PieChart(
                            chartData: mainController.statList1.value,
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
          ],
        ),
      ),
    );
  }
}
