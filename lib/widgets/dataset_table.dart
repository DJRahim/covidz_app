import 'package:covidz/tools/dataset_source.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatasetTable extends StatelessWidget {
  final List<DataColumn> headers;
  final DatasetSource source;
  final mainController = Get.find<MainController>();

  DatasetTable({
    Key? key,
    required this.headers,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: PaginatedDataTable2(
        columnSpacing: 10,
        horizontalMargin: 5,
        minWidth: mainController.minWidth.value,
        empty: const Text(""),
        rowsPerPage: 10,
        wrapInCard: true,
        columns: headers,
        source: source,
      ),
    );
  }
}
