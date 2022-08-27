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
                                  const Text("Variable cible   :  "),
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
                                  const Text("Critere   :  "),
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
                        children: [
                          SfCartesianChart(
                            series: <BoxAndWhiskerSeries<BoxPlotData, dynamic>>[
                              BoxAndWhiskerSeries<BoxPlotData, dynamic>(
                                  dataSource: <BoxPlotData>[
                                    BoxPlotData(
                                      'BoxPlot',
                                      [
                                        0.0,
                                        4.0,
                                        10.0,
                                        3.0,
                                        22.0,
                                        22.0,
                                        23.0,
                                        25.0,
                                        25.0,
                                        25.0,
                                        26.0,
                                        27.0,
                                        27.0
                                      ],
                                    ),
                                  ],
                                  xValueMapper: (BoxPlotData data, _) => data.x,
                                  yValueMapper: (BoxPlotData data, _) =>
                                      data.y),
                            ],
                            primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                labelIntersectAction:
                                    AxisLabelIntersectAction.rotate45),
                            primaryYAxis: NumericAxis(
                                name: 'Age',
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(size: 0)),
                          ),
                          PieChart(
                            chartData: mainController.statList1.value,
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
