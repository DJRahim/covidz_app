import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/dataset_source.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_main.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/dataset_table.dart';
import 'package:covidz/widgets/pie_chart.dart';
import 'package:covidz/widgets/prediction_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

class PredictPage extends StatelessWidget {
  PredictPage({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              MainCard(
                ontap: (vis) {
                  mainController.predictVisibleFunc1(vis);
                },
                vis: mainController.predictVisible1.value,
                title: "Prediction de taux d'infection (FBProphet)",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                                  const AutoSizeText("Choisir un pays :  "),
                                  CountryCodePicker(
                                    onChanged: (countCode) {
                                      mainController.changeCountry(countCode);
                                    },
                                    initialSelection: 'DZ',
                                    favorite: const ['+213', 'DZ'],
                                    showCountryOnly: true,
                                    showOnlyCountryWhenClosed: true,
                                    alignLeft: false,
                                    dialogBackgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    dialogTextStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const AutoSizeText(
                                      "Nombre de jours a predire :  "),
                                  SizedBox(
                                    width: 50.0,
                                    height: 10.0,
                                    child: TextField(
                                      controller:
                                          mainController.textFieldController1,
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
                          Visibility(
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: ElevatedButton(
                                onPressed: () {
                                  mainController.filterMode(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.arrow_right),
                                    AutoSizeText("Parametres"),
                                  ],
                                ),
                              ),
                            ),
                            visible: mainController.filterstate.value,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      mainController.filterMode(false);
                                    },
                                    child: Row(
                                      children: const <Widget>[
                                        Icon(Icons.arrow_drop_down),
                                        AutoSizeText("Parametres"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 600,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Growth : "),
                                            SizedBox(
                                              width: 200,
                                              child: RadioListTile(
                                                title: const Text("Linear"),
                                                value: "linear",
                                                groupValue:
                                                    mainController.growth.value,
                                                onChanged: (val) {
                                                  mainController
                                                      .changeGrowth(val);
                                                  mainController
                                                      .growthStateMode(false);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: RadioListTile(
                                                title: const Text("Logistic"),
                                                value: "logistic",
                                                groupValue:
                                                    mainController.growth.value,
                                                onChanged: (val) {
                                                  mainController
                                                      .changeGrowth(val);
                                                  mainController
                                                      .growthStateMode(true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible:
                                              mainController.growthState.value,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: AutoSizeText(
                                                        "cap :           "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController6,
                                                      // decoration: const InputDecoration(
                                                      //     labelText: "Enter your number"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: AutoSizeText(
                                                        "floor :           "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController7,
                                                      // decoration: const InputDecoration(
                                                      //     labelText: "Enter your number"),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                  "changepoint_range :  "),
                                            ),
                                            SizedBox(
                                              width: 50.0,
                                              height: 10.0,
                                              child: TextField(
                                                controller: mainController
                                                    .textFieldController2,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                  "changepoint_prior_scale :  "),
                                            ),
                                            SizedBox(
                                              width: 50.0,
                                              height: 10.0,
                                              child: TextField(
                                                controller: mainController
                                                    .textFieldController3,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                  "n_changepoints :  "),
                                            ),
                                            SizedBox(
                                              width: 50.0,
                                              height: 10.0,
                                              child: TextField(
                                                controller: mainController
                                                    .textFieldController4,
                                                // decoration: const InputDecoration(
                                                //     labelText: "Enter your number"),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: AutoSizeText(
                                                  "la 1ere date a afficher dans le graphe :  "),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                DatePicker.showDatePicker(
                                                  context,
                                                  theme: DatePickerTheme(
                                                    backgroundColor: Theme.of(
                                                            context)
                                                        .scaffoldBackgroundColor,
                                                    itemStyle: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                    ),
                                                  ),
                                                  showTitleActions: true,
                                                  minTime: DateTime(2018, 3, 5),
                                                  maxTime: DateTime.now(),
                                                  onConfirm: (date) {
                                                    mainController
                                                        .changeFirstDate(date);
                                                  },
                                                  currentTime: DateTime.now(),
                                                  locale: LocaleType.en,
                                                );
                                              },
                                              child: const AutoSizeText(
                                                'Changer la date',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Get.snackbar(
                                    "Chargement",
                                    "requête en cours de traitement",
                                    showProgressIndicator: true,
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: false,
                                    duration: const Duration(hours: 1),
                                  );
                                  var res = await _client.getProphetData(
                                    "prophet",
                                    {
                                      "country": mainController.country.value,
                                      "num_days": mainController
                                          .textFieldController1.text,
                                      "changepoint_range": mainController
                                          .textFieldController2.text,
                                      "changepoints_prior_scale": mainController
                                          .textFieldController3.text,
                                      "n_changepoints": mainController
                                          .textFieldController4.text,
                                      "first_date":
                                          mainController.firstDate.value,
                                      "growth": mainController.growth.value,
                                      "cap": mainController
                                          .textFieldController6.text,
                                      "floor": mainController
                                          .textFieldController7.text,
                                    },
                                  );
                                  Get.closeAllSnackbars();
                                  mainController.changePredcitData1(res[0]);
                                  mainController.changePredcitData2(res[1]);
                                },
                                child: const Text("Afficher"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SecondCard(
                      body: PredictChart(
                        chartDataHist: mainController.predictList1.value,
                        chartDataPredict: mainController.predictList2.value,
                      ),
                    ),
                  ],
                ),
              ),
              MainCard(
                title: "Prediction de l'evolution des cas de COVID-19",
                ontap: (vis) {
                  mainController.predictVisibleFunc2(vis);
                },
                vis: mainController.predictVisible2.value,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondCard(
                      body: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText(
                                        "Dataset d'entraînement : "),
                                  ),
                                  DropdownButton(
                                    value: mainController
                                        .predictTrainDataset.value,
                                    items: mainController.predictDatasets
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeTrainDataset(newValue);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: AutoSizeText("Dataset de test : "),
                                  ),
                                  DropdownButton(
                                    value:
                                        mainController.predictTestDataset.value,
                                    items: mainController.predictDatasets
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changeTestDataset(newValue);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child:
                                        AutoSizeText("Modele de prediction : "),
                                  ),
                                  DropdownButton(
                                    value: mainController
                                        .currentPredictModel.value,
                                    items: mainController.predictModels
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changePredictModel(newValue);
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await getPredictions(context);
                                  mainController.changePredictResult(true);
                                },
                                child: const Text("Executer"),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: mainController.predictResult.value,
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextButton(
                                onPressed: () {
                                  mainController.changePredictResult(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.arrow_right),
                                    AutoSizeText("  liste de résultats"),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SecondCard(
                                  body: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          mainController
                                              .changePredictResult(false);
                                        },
                                        child: Row(
                                          children: const <Widget>[
                                            Icon(Icons.arrow_drop_down),
                                            AutoSizeText(
                                                "  liste de résultats"),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const AutoSizeText(
                                              "  Les valeurs a afficher : "),
                                          SizedBox(
                                            height: 50,
                                            width: 205,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox1.value,
                                              title: const AutoSizeText(
                                                "few_to_no_symptoms",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 0);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 180,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox2.value,
                                              title: const AutoSizeText(
                                                "complications",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 1);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 180,
                                            child: CheckboxListTile(
                                              value: mainController
                                                  .predictListCheckbox3.value,
                                              title: const AutoSizeText(
                                                "death",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              onChanged: (newval) {
                                                mainController
                                                    .changePredictList(
                                                        newval, 2);
                                                mainController
                                                    .updateRows(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 700,
                                        child: SecondCard(
                                          body: DatasetTable(
                                            headers: mainController
                                                .predictHeaders.value,
                                            source: DatasetSource(
                                                mainController, true),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: mainController.predictResult2.value,
                            replacement: Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextButton(
                                onPressed: () {
                                  mainController.changePredictResult2(true);
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(Icons.arrow_right),
                                    AutoSizeText("  statistiques"),
                                  ],
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                SecondCard(
                                  body: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          mainController
                                              .changePredictResult2(false);
                                        },
                                        child: Row(
                                          children: const <Widget>[
                                            Icon(Icons.arrow_drop_down),
                                            AutoSizeText("  statistiques"),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text("variable :  "),
                                              DropdownButton(
                                                value: mainController
                                                    .currentPredictStat.value,
                                                items: mainController
                                                    .predictStatsList
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                      items,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  mainController
                                                      .changePredictStatVariable(
                                                          newValue);
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                  "valeur de prediction :  "),
                                              DropdownButton(
                                                value: mainController
                                                    .currentPredictionVariable
                                                    .value,
                                                items: mainController
                                                    .predictionList
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                      items,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  mainController
                                                      .changePredictionVariable(
                                                          newValue);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              var res =
                                                  await _client.getChartData(
                                                "predict_stat",
                                                {
                                                  "var": mainController
                                                      .currentPredictStat.value,
                                                  "predict_value": mainController
                                                      .currentPredictionVariable
                                                      .value,
                                                  "headers": mainController
                                                      .predictHeadersOld.value,
                                                  "rows": mainController
                                                      .predictRowsOld.value,
                                                },
                                              );
                                              mainController
                                                  .changePredcitData3(res);
                                            },
                                            child: const Text("Afficher"),
                                          ),
                                        ],
                                      ),
                                      PieChart(
                                        chartData:
                                            mainController.predictList3.value,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPredictions(BuildContext context) async {
    var res = await _client.getPredictRowsHeaders(
      "predict",
      {
        "model": mainController.currentPredictModel.value,
        "feature_model": mainController.predictFeatureSelect.value,
        "num_features": mainController.textFieldController12.text,
        "null_percentage": mainController.textFieldController9.text,
        "test_percentage": mainController.textFieldController10.text,
        "standarisation": mainController.standar.value == "Standarisation",
        "normalisation": mainController.standar.value != "Standarisation",
        "axis": mainController.normToggle.value,
        "train_dataset": mainController.predictTrainDataset.value,
        "test_dataset": mainController.predictTestDataset.value,
      },
      mainController,
      context,
    );

    mainController.changePredictList(true, 0);
    mainController.changePredictList(true, 1);
    mainController.changePredictList(true, 2);

    mainController.setMinWidth(18000.0);
    mainController.setPredictRowsAndHeaders(res[0], res[1]);
  }
}
