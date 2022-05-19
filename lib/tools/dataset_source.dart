// ignore_for_file: invalid_use_of_protected_member

import 'package:covidz/tools/main_controller.dart';
import 'package:flutter/material.dart';

class DatasetSource extends DataTableSource {
  DatasetSource(this.controller);
  final MainController controller;

  @override
  DataRow? getRow(int index) {
    return controller.getRow(index);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    return controller.rows.value.length;
  }

  @override
  int get selectedRowCount => 0;
}
