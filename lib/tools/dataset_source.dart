// ignore_for_file: invalid_use_of_protected_member

import 'package:covidz/tools/main_controller.dart';
import 'package:flutter/material.dart';

class DatasetSource extends DataTableSource {
  DatasetSource(this.controller, this.predict);
  final MainController controller;
  final bool predict;

  @override
  DataRow? getRow(int index) {
    if (predict) {
      return controller.getRowPredict(index);
    } else {
      return controller.getRow(index);
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    if (predict) {
      return controller.predictRows.value.length;
    } else {
      return controller.rows.value.length;
    }
  }

  @override
  int get selectedRowCount => 0;
}
