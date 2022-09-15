import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatPage2 extends StatelessWidget {
  StatPage2({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    mainController.getChronicData();
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
                              const Text(
                                "Choisir un critere :  ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  var res = await _client.getChartData(
                                    "chronic_stat",
                                    {
                                      "val": mainController
                                          .currentChronicValue.value,
                                    },
                                  );
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
                      body: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 360,
                            width: 450,
                            child: SfCartesianChart(
                              series: <
                                  BoxAndWhiskerSeries<BoxPlotData, dynamic>>[
                                BoxAndWhiskerSeries<BoxPlotData, dynamic>(
                                  dataSource: mainController.statList2_2.value,
                                  xValueMapper: (BoxPlotData data, _) => data.x,
                                  yValueMapper: (BoxPlotData data, _) => data.y,
                                  width: 0.8,
                                  spacing: 0.2,
                                  dataLabelSettings: const DataLabelSettings(
                                    alignment: ChartAlignment.center,
                                  ),
                                ),
                              ],
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(
                                  width: 0.7,
                                ),
                                arrangeByIndex: true,
                                labelRotation: 90,
                                interval: 1,
                                labelAlignment: LabelAlignment.center,
                              ),
                              primaryYAxis: NumericAxis(
                                name: 'Age',
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(size: 0),
                              ),
                              title: ChartTitle(
                                  alignment: ChartAlignment.center,
                                  textStyle: const TextStyle(fontSize: 13),
                                  text: "Graphe des boxplots basé sur l'age"),
                            ),
                          ),
                          PieChart(
                            chartData: mainController.statList2.value,
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
            Obx(
              () => SecondCard(
                body: Column(
                  children: [
                    const AutoSizeText(
                      "Graphe de la correlation entre les maladies chroniques et l'evolution des cas",
                      maxFontSize: 14,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 400,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelRotation: 70,
                          labelAlignment: LabelAlignment.end,
                        ),
                        legend: Legend(
                          isVisible: true,
                        ),
                        series: mainController.corrChronicData.value,
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
