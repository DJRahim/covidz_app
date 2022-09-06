// ignore_for_file: invalid_use_of_protected_member

import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/classes.dart';
import 'package:fl_heatmap/fl_heatmap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  final DioClient _client = DioClient();

  // Variables
  final datasets = ["Dataset d'enquete", "Our World In Data (OWID)"].obs;
  final currentDataset = "Dataset d'enquete".obs;

  final statVariables = ["age", "sexe", "groupe sanguin"];
  final currentStatVariable = "groupe sanguin".obs;

  final statValues = [
    "tout",
    "nombre de deces",
    "nombre de personnees hospitalises",
    "nombre d'entrants en soins intensifs",
  ];

  final compVariables = [
    "Activité physique",
    "Tabagisme",
    "Fréquence de sortie",
    "Transport public",
    "Port du masque",
    "Distanciation sociale",
    "Source principale des repas",
    "Nombre de repas par jour",
    "Nombre de verres d'eau bus par jour",
  ];

  final currentStatvalue = "tout".obs;

  final currentChronicValue = "tout".obs;

  final currentCompValue2 = "tout".obs;

  final currentCompVar = "Activité physique".obs;

  final currentCompValue = "tout".obs;

  final filterstate = false.obs;

  final growthState = false.obs;

  final statList1 = <ChartData>[].obs;

  final statList1_2 = <BoxPlotData>[].obs;

  final statList2 = <ChartData>[].obs;

  final statList2_2 = <BoxPlotData>[].obs;

  final compList = <ChartData>[].obs;

  final compList2 = <BoxPlotData>[].obs;

  final predictList1 = <ChartData>[].obs;

  final predictList2 = <ChartData>[].obs;

  final predictList3 = <ChartData>[].obs;

  final country = "DZ".obs;

  final firstDate = DateTime(2020, 02, 01).obs;

  final growth = "linear".obs;

  final headers = <DataColumn>[
    const DataColumn(
      label: Text(''),
    ),
  ].obs;

  final rows = <DataRow>[].obs;

  final minWidth = 15000.0.obs;

  final featureSelectionMethods = [
    "FeatureWiz",
    "Score de Chi-2",
    "Score de Ficher",
    "mutual Info Classifier",
  ];

  final currentFeatureMethode = "Score de Chi-2".obs;

  final featuresList = <ChartData>[].obs;

  final variableCibleList = [
    "evolution",
    "hospitalisation",
    "entrer en soins intensifs",
    "deces",
  ];

  final currentVariableCible = "evolution".obs;

  final standar = "Standarisation".obs;

  final normToggle = "Horizontal".obs;

  final predictModels = [
    "Decision Tree Classifier",
    "Decision Tree Regressor",
    "Random Forest Classifier",
    "Random Forest Regressor",
    "Adaboost",
    "SVM",
    "Naive Bayes",
    "Linear regression",
    "Logistic regression",
  ];

  final predictModelsClasses = [
    "Supervised Learning - Multiclass Classification",
    "Supervised Learning - Regression",
    "Ensemble Learning - Multiclass Classification",
    "Ensemble Learning - Regression",
    "Ensemble Learning - Classification and Regression",
    "Supervised Learning - Classification and Regression",
    "Probabilistic Supervised learning - Multiclass Classification",
    "Supervised Learning - Regression",
    "Supervised Learning - Regression",
  ];

  final currentPredictModel = "Adaboost".obs;

  final currentPredictModelClass =
      "Ensemble Learning - Classification and Regression".obs;

  final predictFeatureSelect = "FeatureWiz".obs;

  final predictDatasets = ["Dataset d'enquete", "Dataset genere"];

  final predictTrainDataset = "Dataset d'enquete".obs;

  final predictTestDataset = "Dataset d'enquete".obs;

  final predictListCheckbox1 = true.obs;
  final predictListCheckbox2 = true.obs;
  final predictListCheckbox3 = true.obs;

  final predictHeaders = <DataColumn>[
    const DataColumn(
      label: Text(''),
    ),
  ].obs;

  final predictRows = <DataRow>[].obs;

  final predictRowsOld = [].obs;

  final predictHeadersOld = [].obs;

  final predictResult = false.obs;

  final predictResult2 = false.obs;

  final predictfeatureSelectionMethods = [
    "Aucune",
    "FeatureWiz",
    "Score de Chi-2",
    "Score de Ficher",
    "mutual Info Classifier",
  ];

  final predictStatsList = [
    "aucune",
    "age",
    "sexe",
    "groupe sanguin",
    "vaccination",
    "condition medicale",
  ];

  final currentPredictStat = "aucune".obs;

  final predictionList = [
    "tout",
    "few_to_no_symptoms",
    "few_complications",
    "critical_case",
  ];

  final currentPredictionVariable = "critical_case".obs;

  final usersList = [].obs;

  final usersList2 = [].obs;

  static const rows2 = [
    "Predicted (critical_case)",
    "Predicted (few_complications)",
    "Predicted (few_to_no_symptoms)"
  ];
  static const columns = [
    "Actual (critical_case)",
    "Actual (few_complications)",
    "Actual (few_to_no_symptoms)"
  ];

  final heatmapData = HeatmapData(rows: rows2, columns: columns, items: []).obs;

  static const rowsComp = [
    "fruits",
    "vegetables",
    "milk_products",
    "meat",
    "rice / pasta",
    "bread",
    "sweets",
    "coffee / tea",
    "juice / soda",
    "tisane",
  ];

  static const columnsComp = [
    "2+/day",
    "1/day",
    "2-5/week",
    "1/week",
    "rarely",
  ];

  final heatmapDataComp =
      HeatmapData(rows: rowsComp, columns: columnsComp, items: []).obs;

  final performances = <ChartData>[].obs;

  final corrChronicData = <ChartSeries<BoxPlotData, String>>[].obs;

  final corrChronicDataPredict = <ChartSeries<BoxPlotData, String>>[].obs;

  // Controllers

  final PageController page = PageController();

  final textFieldController1 = TextEditingController(text: "100");
  final textFieldController2 = TextEditingController(text: "0.9");
  final textFieldController3 = TextEditingController(text: "0.9");
  final textFieldController4 = TextEditingController(text: "0");
  var textFieldController5 = TextEditingController(text: "100");
  final textFieldController6 = TextEditingController(text: "2600");
  final textFieldController7 = TextEditingController(text: "0");
  final textFieldController8 = TextEditingController(text: "20");
  final textFieldController9 = TextEditingController(text: "80");
  final textFieldController10 = TextEditingController(text: "20");
  final textFieldController11 = TextEditingController(text: "20");
  final textFieldController12 = TextEditingController(text: "60");
  var textFieldController13 = TextEditingController(text: "");
  var textFieldController14 = TextEditingController(text: "");
  var textFieldController15 = TextEditingController(text: "");
  var textFieldController16 = TextEditingController(text: "");
  var textFieldController17 = TextEditingController(text: "");

  final statVisible1 = false.obs;
  final statVisible2 = false.obs;
  final statVisible3 = false.obs;
  final datasetVisible1 = true.obs;
  final predictVisible1 = false.obs;
  final predictVisible2 = false.obs;
  final settingsVisible1 = true.obs;
  final rowNumberVis = false.obs;
  final settingsPredict = false.obs;
  final predictPerformance = false.obs;

  final activeUser = true.obs;

  // Functions

  void changeDataset(newDataset) {
    currentDataset.value = newDataset;
  }

  void changeStatVariable(newvar) {
    currentStatVariable.value = newvar;
  }

  void changeStatValue(newval) {
    currentStatvalue.value = newval;
  }

  void changeChronicValue(newval) {
    currentChronicValue.value = newval;
  }

  void changeCompValue2(newval) {
    currentCompValue2.value = newval;
  }

  void changeCompVariable(newvar) {
    currentCompVar.value = newvar;
  }

  void changeCompValue(newval) {
    currentCompValue.value = newval;
  }

  void filterMode(newval) {
    filterstate.value = newval;
  }

  void growthStateMode(newval) {
    growthState.value = newval;
  }

  void changeStatData1(newval) {
    statList1.value = newval[0];
    statList1_2.value = newval[1];
  }

  void changeStatData2(newval) {
    statList2.value = newval[0];
    statList2_2.value = newval[1];
  }

  void changeCompData(newval) {
    compList.value = newval[0];
    compList2.value = newval[1];
  }

  void changePredcitData1(newval) {
    predictList1.value = newval;
  }

  void changePredcitData2(newval) {
    predictList2.value = newval;
  }

  void changePredcitData3(newval) {
    predictList3.value = newval;
  }

  void changeCountry(newval) {
    country.value = newval;
  }

  void changeFirstDate(newval) {
    firstDate.value = newval;
  }

  void changeGrowth(newval) {
    growth.value = newval;
  }

  void setRowsAndHeaders(head, row) {
    headers.value = head;
    rows.value = row;
  }

  DataRow getRow(int index) {
    return rows.value.elementAt(index);
  }

  void setMinWidth(newval) {
    minWidth.value = newval;
  }

  void datasetVisibleFunc1(vis) {
    datasetVisible1.value = !vis;
  }

  void settingsVisibleFunc1(vis) {
    settingsVisible1.value = !vis;
  }

  void changeFeatureSelection(newval) {
    currentFeatureMethode.value = newval;
  }

  void changeFeatureList(newval) {
    featuresList.value = newval;
  }

  void changeVariableCible(newval) {
    currentVariableCible.value = newval;
  }

  void changeStandar(newval) {
    standar.value = newval;
  }

  void changeNorm(index) {
    if (index == 0) {
      normToggle.value = "Horizontal";
    } else {
      normToggle.value = "Vertical";
    }
  }

  void changePredictModel(newval) {
    currentPredictModel.value = newval;
  }

  void changePredictModelClass(newval) {
    currentPredictModelClass.value =
        predictModelsClasses[predictModels.indexOf(newval)];
  }

  void changePredictFeatureSelect(newval) {
    predictFeatureSelect.value = newval;
  }

  void changeTrainDataset(newval) {
    predictTrainDataset.value = newval;
  }

  void changeTestDataset(newval) {
    predictTestDataset.value = newval;
  }

  void changePredictList(newval, i) {
    if (i == 0) {
      predictListCheckbox1.value = newval;
    }
    if (i == 1) {
      predictListCheckbox2.value = newval;
    }
    if (i == 2) {
      predictListCheckbox3.value = newval;
    }
  }

  DataRow getRowPredict(int index) {
    return predictRows.value.elementAt(index);
  }

  void setPredictRowsAndHeaders(head, row) {
    predictHeaders.value = head;
    predictRows.value = row;
  }

  void changePredictResult(newval) {
    predictResult.value = newval;
  }

  void changePredictResult2(newval) {
    predictResult2.value = newval;
  }

  void updateRows(BuildContext context) {
    predictRows.value = <DataRow>[];
    var checkboxlist = [];

    if (predictListCheckbox1.value) {
      checkboxlist.add(2);
    }
    if (predictListCheckbox2.value) {
      checkboxlist.add(0);
    }
    if (predictListCheckbox3.value) {
      checkboxlist.add(1);
    }

    for (var item in predictRowsOld.value) {
      if (checkboxlist.contains(item[1])) {
        String t = "";
        Color? c;
        if (item[1] == 2) {
          c = Theme.of(context).colorScheme.primaryContainer;
          t = "few_to_no_symptoms";
        }
        if (item[1] == 1) {
          c = Theme.of(context).colorScheme.secondaryContainer;
          t = "few_complications";
        }
        if (item[1] == 0) {
          c = Theme.of(context).colorScheme.tertiaryContainer;
          t = "critical_case";
        }

        predictRows.value.add(
          DataRow(
            cells: List<DataCell>.generate(
              item.length,
              (index) => DataCell(
                AutoSizeText(
                  index == 1 ? t : item[index].toString(),
                  minFontSize: 10,
                ),
              ),
            ),
            color: MaterialStateProperty.resolveWith((states) => c),
          ),
        );
      }
    }
  }

  void changePredictStatVariable(newval) {
    currentPredictStat.value = newval;
  }

  void changePredictionVariable(newval) {
    currentPredictionVariable.value = newval;
  }

  void updateDatasets(newval) {
    datasets.value = newval;
  }

  void changeRowNumberVis(newval) {
    rowNumberVis.value = newval;
    textFieldController5 = TextEditingController(text: "0");
  }

  void changeSettingsPredict(newval) {
    settingsPredict.value = newval;
  }

  void changePredictPerformance(newval) {
    predictPerformance.value = newval;
  }

  void getUsersList() async {
    usersList.value = await _client.getUsersList("user_requests", {});
  }

  void getUsersList2() async {
    usersList2.value = await _client.getUsersList("user_list", {});
  }

  void resetAuthPage() {
    textFieldController13 = TextEditingController(text: "");
    textFieldController14 = TextEditingController(text: "");
    textFieldController15 = TextEditingController(text: "");
    textFieldController16 = TextEditingController(text: "");
    textFieldController17 = TextEditingController(text: "");
  }

  void changeHeatMap(newval) {
    heatmapData.value = HeatmapData(
      columns: columns,
      rows: rows2,
      items: [
        for (int row = 0; row < rows2.length; row++)
          for (int col = 0; col < columns.length; col++)
            HeatmapItem(
              value: newval[row][col].toDouble(),
              xAxisLabel: columns[col],
              yAxisLabel: rows2[row],
            ),
      ],
      colorPalette: colorPaletteRed,
    );
  }

  void changePerformances(newval) {
    List<ChartData> listChart = [];

    listChart.add(ChartData("Accuracy", newval["Accuracy"].toDouble()));
    listChart.add(ChartData("Precision", newval["Precision"].toDouble()));
    listChart.add(ChartData("Recall", newval["Recall"].toDouble()));
    listChart.add(ChartData("F1 score", newval["F1 score"].toDouble()));

    performances.value = listChart;
  }

  void changeHeatMapComp(newval) {
    heatmapDataComp.value = HeatmapData(
      columns: columnsComp,
      rows: rowsComp,
      items: [
        for (int row = 0; row < rowsComp.length; row++)
          for (int col = 0; col < columnsComp.length; col++)
            HeatmapItem(
              value: newval[row][col].toDouble(),
              xAxisLabel: columnsComp[col],
              yAxisLabel: rowsComp[row],
            ),
      ],
      colorPalette: colorPaletteGreen,
    );
  }

  void updateCorrChronicData(newval) {
    var listItems = <ChartSeries<BoxPlotData, String>>[];

    for (int i = 0; i < 3; i++) {
      listItems.add(
        StackedColumn100Series<BoxPlotData, String>(
          dataSource: newval,
          xValueMapper: (BoxPlotData data, _) => data.x,
          yValueMapper: (BoxPlotData data, _) => data.y[i],
          width: 0.6,
          spacing: 0.1,
        ),
      );
    }

    corrChronicData.value = listItems;
  }

  void updateCorrChronicDataPredict(newval) {
    var listItems = <ChartSeries<BoxPlotData, String>>[];

    for (int i = 0; i < 3; i++) {
      listItems.add(
        StackedColumn100Series<BoxPlotData, String>(
          dataSource: newval,
          xValueMapper: (BoxPlotData data, _) => data.x,
          yValueMapper: (BoxPlotData data, _) => data.y[i],
          width: 0.6,
          spacing: 0.1,
        ),
      );
    }

    corrChronicDataPredict.value = listItems;
  }

  void getChronicData() async {
    var res2 = await _client.getChartDataChronic(
      "chronic_stat_2",
      {},
    );
    updateCorrChronicData(res2);
  }

  Future<void> checkActiveUser(email) async {
    var res = await _client.getQuery("check_disabled", {'email': email});

    var dict = Map<String, dynamic>.from(res.data);

    activeUser.value = !dict['message'];
  }
}
