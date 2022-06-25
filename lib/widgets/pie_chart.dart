import 'package:covidz/tools/classes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final List<ChartData> chartData;

  const PieChart({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 500,
      child: Center(
        child: SfCircularChart(
          series: <CircularSeries>[
            // Render pie chart
            PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              explode: true,
              explodeGesture: ActivationMode.singleTap,
              selectionBehavior: SelectionBehavior(
                enable: true,
              ),
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                showZeroValue: false,
              ),
            ),
          ],
          legend: Legend(
            isVisible: true,
            position: LegendPosition.right,
          ),
        ),
      ),
    );
  }
}
