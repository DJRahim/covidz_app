// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/dataset_source.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/dataset_table.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class DatasetPage extends StatelessWidget {
  DatasetPage({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final _url = Uri.parse("https://forms.gle/pZqRVXpq2qVThSby8");
  final DioClient _client = DioClient();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    mainController.readDatasets();

    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => SecondCard(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Choisir le dataset :  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  DropdownButton(
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
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: mainController.rowNumberVis.value,
                                    onChanged: (val) {
                                      mainController.changeRowNumberVis(val);
                                      if (val == false) {
                                        mainController.textFieldController5 =
                                            TextEditingController(text: "0");
                                      }
                                    },
                                  ),
                                  const Text(
                                      "Afficher un nombre limite de lignes"),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible: mainController.rowNumberVis.value,
                            child: SizedBox(
                              height: 25.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("Nombre de lignes a afficher :  "),
                                  SizedBox(
                                    width: 50.0,
                                    height: 15.0,
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
                            ),
                          ),
                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['csv'],
                                  );

                                  String? f = result?.files.single.path;
                                  String? fileName = result?.files.single.name;

                                  var str = fileName!
                                      .substring(0, fileName.length - 4);

                                  if (result != null) {
                                    File file = File(f!);

                                    final contents = await file.readAsString();

                                    // send to api
                                    _client.getQuery(
                                      "new_dataset",
                                      {
                                        "name": str,
                                        "contents": contents,
                                      },
                                    );

                                    mainController.addingDataset(str);
                                  }
                                },
                                child: const Text("Ajouter un dataset"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.snackbar(
                                    "Chargement",
                                    "telechargement du dataset",
                                    showProgressIndicator: true,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: false,
                                    duration: const Duration(hours: 1),
                                  );
                                  _client.getQuery(
                                    "refresh_dataset",
                                    {
                                      "dataset":
                                          mainController.currentDataset.value,
                                    },
                                  );
                                  Get.closeAllSnackbars();
                                },
                                child: const Text("Rafraîchir le dataset"),
                              ),
                              mainController.currentDataset.value ==
                                      "Donnees du formulaire"
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        if (!await launchUrl(_url,
                                            mode: LaunchMode
                                                .externalApplication)) {
                                          throw 'Could not launch $_url';
                                        }
                                      },
                                      child: const Text(
                                          "Acceder au formulaire (Google Forms)"),
                                    )
                                  : Container(),
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
                        body: DatasetTable(
                          headers: mainController.headers.value,
                          source: DatasetSource(mainController, false),
                        ),
                      ),
                    ),
                  ],
                ),
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
