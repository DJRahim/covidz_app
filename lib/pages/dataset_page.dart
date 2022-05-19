// ignore_for_file: invalid_use_of_protected_member

import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/dataset_source.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/dataset_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DatasetPage extends StatelessWidget {
  DatasetPage({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final _url = Uri.parse("https://forms.gle/pZqRVXpq2qVThSby8");
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MainCard(
              title: "Dataset Page",
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fields
                  SecondCard(
                    body: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Choisir le dataset :  "),
                                Obx(
                                  () => DropdownButton(
                                    value: mainController.currentDataset.value,
                                    items: mainController.datasets
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController.changeDataset(newValue);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Nombre de lignes a afficher :  "),
                                SizedBox(
                                  width: 50.0,
                                  height: 10.0,
                                  child: TextField(
                                    controller:
                                        mainController.textFieldController5,
                                    // decoration: const InputDecoration(
                                    //     labelText: "Enter your number"),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text("Rafraîchir le dataset"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!await launchUrl(_url,
                                    mode: LaunchMode.externalApplication)) {
                                  throw 'Could not launch $_url';
                                }
                              },
                              child: const Text(
                                  "Acceder au formulaire (Google Forms)"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (mainController.currentDataset.value ==
                                    "Donnees du formulaire") {
                                  mainController.setMinWidth(18000.0);
                                } else {
                                  mainController.setMinWidth(7000.0);
                                }
                                getDataset();
                              },
                              child: const Text("Afficher"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Table
                  SizedBox(
                    width: 700,
                    height: 500,
                    child: SecondCard(
                      body: Obx(
                        () => DatasetTable(
                          headers: mainController.headers.value,
                          source: DatasetSource(mainController),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getDataset() async {
    var res = await _client.getRowsHeaders(
      "dataset",
      {
        "dataset": mainController.currentDataset.value,
        "numrows": mainController.textFieldController5.text
      },
    );
    mainController.setRowsAndHeaders(res[0], res[1]);
  }
}
