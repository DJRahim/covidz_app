// ignore_for_file: invalid_use_of_protected_member

import 'package:covidz/tools/classes.dart';
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

  // Controllers

  final PageController page = PageController();

  final textFieldController1 = TextEditingController(text: "100");
  final textFieldController2 = TextEditingController(text: "0.8");
  final textFieldController3 = TextEditingController(text: "0.05");
  final textFieldController4 = TextEditingController(text: "0");
  final textFieldController5 = TextEditingController(text: "100");

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
}
