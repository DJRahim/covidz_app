import 'package:covidz/tools/classes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictChart extends StatelessWidget {
  final List<ChartData> chartDataHist;
  final List<ChartData> chartDataPredict;

  const PredictChart({
    Key? key,
    required this.chartDataHist,
    required this.chartDataPredict,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Center(
        child: SfCartesianChart(
          legend: Legend(isVisible: true, position: LegendPosition.bottom),
          primaryXAxis: CategoryAxis(),
          series: <CartesianSeries>[
            // Render column series
            ScatterSeries<ChartData, String>(
              color: const Color.fromARGB(255, 121, 15, 15),
              legendItemText: "Donnees historiques",
              dataSource: chartDataHist,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              markerSettings: const MarkerSettings(
                height: 6,
                width: 6,
              ),
            ),
            // Render line series
            SplineSeries<ChartData, String>(
              color: Colors.blue,
              legendItemText: "Prediction",
              dataSource: chartDataPredict,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
            ),
          ],
        ),
      ),
    );
  }
}
