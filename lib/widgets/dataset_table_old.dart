import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class DatasetTable extends StatelessWidget {
  final List headers;
  final List rows;

  const DatasetTable({
    Key? key,
    required this.headers,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Editable(
        columns: headers,
        rows: rows,
        showCreateButton: true,
        tdStyle: const TextStyle(fontSize: 12),
        thSize: 15,
        columnRatio: 0.08,
        showSaveIcon: true,
        borderColor: const Color.fromARGB(255, 7, 11, 22),
        borderWidth: 0.8,
        createButtonIcon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        createButtonColor: Theme.of(context).colorScheme.background,
        thPaddingTop: 3.5,
        thPaddingBottom: 3.5,
        thAlignment: TextAlign.center,
        zebraStripe: true,
        stripeColor1: Theme.of(context).colorScheme.tertiary,
        stripeColor2: Theme.of(context).colorScheme.background,
        onRowSaved: (value) {
          print(value);
        },
      ),
    );
  }
}
