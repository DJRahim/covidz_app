import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'http://127.0.0.1:1034/';

  Future<List> getChartData(String route, Map<String, dynamic> args) async {
    Response data = await _dio.get(_baseUrl + route, queryParameters: args);

    var list = List<dynamic>.from(data.data);

    List<ChartData> listChart = [];

    for (var i in list) {
      listChart.add(ChartData(i[0], i[1].toDouble()));
    }

    return listChart;
  }

  Future<List> getProphetData(String route, Map<String, dynamic> args) async {
    Response data = await _dio.get(_baseUrl + route, queryParameters: args);

    var list = List<dynamic>.from(data.data);

    List<ChartData> listChart1 = [];
    List<ChartData> listChart2 = [];

    for (var i in list[0]) {
      listChart1.add(ChartData(i[0], i[1].toDouble()));
    }

    for (var i in list[1]) {
      listChart2.add(ChartData(i[0], i[1].toDouble()));
    }

    return [listChart1, listChart2];
  }

  Future<List> getRowsHeaders(String route, Map<String, dynamic> args) async {
    Response data = await _dio.get(_baseUrl + route, queryParameters: args);

    var list = List<dynamic>.from(data.data);

    List<DataColumn> listChart1 = [];
    List<DataRow> listChart2 = [];

    for (var i in list[0]) {
      listChart1.add(
        DataColumn(
          label: AutoSizeText(
            i,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            minFontSize: 10,
          ),
        ),
      );
    }

    for (var i in list[1]) {
      listChart2.add(
        DataRow(
          cells: List<DataCell>.generate(
            i.length,
            (index) => DataCell(
              AutoSizeText(
                i[index].toString(),
                minFontSize: 10,
              ),
            ),
          ),
        ),
      );
    }

    return [listChart1, listChart2];
  }

  Future<void> getQuery(String route, Map<String, dynamic> args) async {
    Response data = await _dio.get(_baseUrl + route, queryParameters: args);
  }

  Future<List> getPredictRowsHeaders(String route, Map<String, dynamic> args,
      MainController control, BuildContext context) async {
    Response data = await _dio.get(_baseUrl + route, queryParameters: args);

    var list = List<dynamic>.from(data.data);

    List<DataColumn> listChart1 = [];
    List<DataRow> listChart2 = [];

    for (var i in list[0]) {
      listChart1.add(
        DataColumn(
          label: AutoSizeText(
            i,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            minFontSize: 10,
          ),
        ),
      );
    }

    for (var i in list[1]) {
      String t = "";
      Color? c;
      if (i[1] == 2) {
        c = Theme.of(context).colorScheme.primaryContainer;
        t = "few_to_no_symptoms";
      }
      if (i[1] == 0) {
        c = Theme.of(context).colorScheme.secondaryContainer;
        t = "complications";
      }
      if (i[1] == 1) {
        c = Theme.of(context).colorScheme.tertiaryContainer;
        t = "death";
      }

      listChart2.add(
        DataRow(
          cells: List<DataCell>.generate(
            i.length,
            (index) => DataCell(
              AutoSizeText(
                index == 1 ? t : i[index].toString(),
                minFontSize: 10,
              ),
            ),
          ),
          color: MaterialStateProperty.resolveWith((states) => c),
        ),
      );
    }

    control.predictRowsOld.value = list[1];

    return [listChart1, listChart2];
  }
}
