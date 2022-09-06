import 'dart:convert';
import 'dart:ffi';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/classes.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DioClient {
  final Dio _dio = Dio();
  final box = GetStorage();

  final _baseUrl = 'http://127.0.0.1:1035/';

  Future<Response> getQuery(String route, Map<String, dynamic> args) async {
    await getToken();
    _dio.options.headers["authorization"] = box.read("token");

    Response data = await _dio.get(_baseUrl + route, queryParameters: args);
    return data;
  }

  Future<String> getToken() async {
    var email = box.read("email");
    var passwd = box.read("passwd");

    try {
      Response data = await _dio.get(
        "${_baseUrl}token",
        queryParameters: {
          "email": email,
          "password": passwd,
        },
      );

      var token = data.data['token'];
      box.write("token", token);

      var user_type = data.data['user_type'];
      box.write("user_type", user_type);
      return user_type;
    } on Exception catch (e) {
      return "error";
    }
  }

  Future<List> getChartData(String route, Map<String, dynamic> args) async {
    _dio.options.headers["authorization"] = box.read("token");

    Response data = await _dio.post(_baseUrl + route, data: jsonEncode(args));

    var list = List<dynamic>.from(data.data);

    List<ChartData> listChart = [];
    List<BoxPlotData> listChart2 = <BoxPlotData>[];

    double s = 0.0;

    for (var i in list[0]) {
      s += i[1];
    }

    for (var i in list[0]) {
      listChart.add(ChartData(i[0],
          double.parse((i[1].toDouble() * 100.0 / s).toStringAsFixed(1))));
    }

    for (var i in list[1]) {
      var listInt = i[1];
      var listDouble = listInt
          .map<double>((j) => double.parse(j.toDouble().toStringAsFixed(1)))
          .toList();

      var a = listDouble;
      if (listDouble.length <= 1) {
        a = [0.1, 0.2];
      }

      listChart2.add(BoxPlotData(i[0], a));
    }

    return [listChart, listChart2];
  }

  Future<List> getChartDataChronic(
      String route, Map<String, dynamic> args) async {
    _dio.options.headers["authorization"] = box.read("token");

    Response data = await _dio.post(_baseUrl + route, data: jsonEncode(args));

    var list = List<dynamic>.from(data.data);

    List<BoxPlotData> listChart = [];

    for (var i in list) {
      listChart.add(BoxPlotData(i[0], i[1]));
    }

    return listChart;
  }

  Future<List> getChartDataComp(String route, Map<String, dynamic> args) async {
    _dio.options.headers["authorization"] = box.read("token");

    Response data = await _dio.post(_baseUrl + route, data: jsonEncode(args));

    var list = List<dynamic>.from(data.data);

    return list;
  }

  Future<List> getChartDataFeatures(
      String route, Map<String, dynamic> args) async {
    _dio.options.headers["authorization"] = box.read("token");

    Response data = await _dio.post(_baseUrl + route, data: jsonEncode(args));

    var list = List<dynamic>.from(data.data);

    List<ChartData> listChart = [];

    for (var i in list) {
      listChart.add(ChartData(i[0], i[1].toDouble()));
    }

    return listChart;
  }

  Future<List> getProphetData(String route, Map<String, dynamic> args) async {
    Response data = await getQuery(route, args);

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
    Response data = await getQuery(route, args);

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

  Future<List> getPredictRowsHeaders(String route, Map<String, dynamic> args,
      MainController control, BuildContext context) async {
    Response data = await getQuery(route, args);

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
        t = "critical_case";
      }
      if (i[1] == 1) {
        c = Theme.of(context).colorScheme.tertiaryContainer;
        t = "few_complications";
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
    control.predictHeadersOld.value = list[0];

    return [listChart1, listChart2, list[2]];
  }

  Future<List> signup(String route, Map<String, dynamic> args) async {
    var list;
    try {
      Response data = await _dio.get(_baseUrl + route, queryParameters: args);
      list = List<dynamic>.from(data.data);
    } on Exception catch (e) {
      list = [
        {'message': 'Demande déjà existante'},
        400,
      ];
    }

    return list;
  }

  // Admin Functions
  Future<List> getUsersList(String route, Map<String, dynamic> args) async {
    Response data = await getQuery(route, args);

    var list = List.from(data.data);

    return list;
  }

  Future<void> acceptRejectRequest(
      String route, Map<String, dynamic> args) async {
    Response data = await getQuery(route, args);
  }
}
