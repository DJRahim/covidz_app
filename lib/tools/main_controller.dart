// ignore_for_file: invalid_use_of_protected_member

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidz/tools/classes.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  // Variables
  final datasets = ["Donnees du formulaire", "Our World In Data (OWID)"];
  final currentDataset = "Donnees du formulaire".obs;

  final statVariables = ["age", "sexe", "groupe sanguin"];
  final currentStatVariable = "groupe sanguin".obs;

  final statValues = [
    "nombre de deces",
    "nombre de personnees hospitalises",
    "nombre d'entrants en soins intensifs",
  ];
  final currentStatvalue = "nombre de deces".obs;

  final currentChronicValue = "nombre de deces".obs;

  final filterstate = false.obs;

  final growthState = false.obs;

  final statList1 = <ChartData>[].obs;

  final statList2 = <ChartData>[].obs;

  final predictList1 = <ChartData>[].obs;

  final predictList2 = <ChartData>[].obs;

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
    "Random Forest",
    "Adaboost",
    "SVM",
    "Naive Bayes",
  ];

  final currentPredictModel = "Adaboost".obs;

  final predictFeatureSelect = "FeatureWiz".obs;

  final predictDatasets = ["formulaire"];

  final predictTrainDataset = "formulaire".obs;

  final predictTestDataset = "formulaire".obs;

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

  final predictResult = false.obs;

  final predictfeatureSelectionMethods = [
    "Aucune",
    "FeatureWiz",
    "Score de Chi-2",
    "Score de Ficher",
    "mutual Info Classifier",
  ];

  // Controllers

  final PageController page = PageController();

  final textFieldController1 = TextEditingController(text: "100");
  final textFieldController2 = TextEditingController(text: "0.8");
  final textFieldController3 = TextEditingController(text: "0.05");
  final textFieldController4 = TextEditingController(text: "0");
  final textFieldController5 = TextEditingController(text: "100");
  final textFieldController6 = TextEditingController(text: "2600");
  final textFieldController7 = TextEditingController(text: "0");
  final textFieldController8 = TextEditingController(text: "20");
  final textFieldController9 = TextEditingController(text: "80");
  final textFieldController10 = TextEditingController(text: "20");
  final textFieldController11 = TextEditingController(text: "20");
  final textFieldController12 = TextEditingController(text: "60");

  final statVisible1 = false.obs;
  final statVisible2 = false.obs;
  final statVisible3 = false.obs;
  final datasetVisible1 = false.obs;
  final predictVisible1 = false.obs;
  final predictVisible2 = false.obs;
  final settingsVisible1 = false.obs;

  final sideMenuDisplay = SideMenuDisplayMode.open.obs;

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

  void filterMode(newval) {
    filterstate.value = newval;
  }

  void growthStateMode(newval) {
    growthState.value = newval;
  }

  void changeStatData1(newval) {
    statList1.value = newval;
  }

  void changeStatData2(newval) {
    statList2.value = newval;
  }

  void changePredcitData1(newval) {
    predictList1.value = newval;
  }

  void changePredcitData2(newval) {
    predictList2.value = newval;
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

  void statVisibleFunc1(vis) {
    statVisible1.value = !vis;
  }

  void statVisibleFunc2(vis) {
    statVisible2.value = !vis;
  }

  void statVisibleFunc3(vis) {
    statVisible3.value = !vis;
  }

  void datasetVisibleFunc1(vis) {
    datasetVisible1.value = !vis;
  }

  void predictVisibleFunc1(vis) {
    predictVisible1.value = !vis;
  }

  void predictVisibleFunc2(vis) {
    predictVisible2.value = !vis;
  }

  void settingsVisibleFunc1(vis) {
    settingsVisible1.value = !vis;
  }

  void changeSideMenuDisplay() {
    if (sideMenuDisplay.value == SideMenuDisplayMode.open) {
      sideMenuDisplay.value = SideMenuDisplayMode.compact;
    } else {
      sideMenuDisplay.value = SideMenuDisplayMode.open;
    }
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
    if (index == 1) {
      normToggle.value = "Horizontal";
    } else {
      normToggle.value = "Vertical";
    }
  }

  void changePredictModel(newval) {
    currentPredictModel.value = newval;
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
        if (item[1] == 0) {
          c = Theme.of(context).colorScheme.secondaryContainer;
          t = "complications";
        }
        if (item[1] == 1) {
          c = Theme.of(context).colorScheme.tertiaryContainer;
          t = "death";
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
}
