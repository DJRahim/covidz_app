import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/widgets/card_second.dart';
import 'package:covidz/widgets/prediction_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

class PredictPage1 extends StatelessWidget {
  PredictPage1({Key? key}) : super(key: key);
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
              SecondCard(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondCard(
                      body: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const AutoSizeText(
                                        "Choisir un pays :  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      CountryCodePicker(
                                        onChanged: (countCode) {
                                          mainController
                                              .changeCountry(countCode);
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
                                        "Nombre de jours a predire :  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.0,
                                        height: 10.0,
                                        child: TextField(
                                          controller: mainController
                                              .textFieldController1,
                                          // decoration: const InputDecoration(
                                          //     labelText: "Enter your number"),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Modele  :  ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  DropdownButton(
                                    value: mainController
                                        .currentPredictModel1.value,
                                    items: mainController.predictModels1
                                        .map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      mainController
                                          .changePredictModel1(newValue);
                                    },
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
                                        Visibility(
                                          visible: mainController
                                                  .currentPredictModel1.value ==
                                              "Prophet",
                                          replacement: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child:
                                                        AutoSizeText("p :   "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController18,
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
                                                    child:
                                                        AutoSizeText("d :   "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController19,
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
                                                    child:
                                                        AutoSizeText("q :   "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController20,
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
                                                        "train % :   "),
                                                  ),
                                                  SizedBox(
                                                    width: 50.0,
                                                    height: 10.0,
                                                    child: TextField(
                                                      controller: mainController
                                                          .textFieldController21,
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Growth : "),
                                                  SizedBox(
                                                    width: 200,
                                                    child: RadioListTile(
                                                      title:
                                                          const Text("Linear"),
                                                      value: "linear",
                                                      groupValue: mainController
                                                          .growth.value,
                                                      onChanged: (val) {
                                                        mainController
                                                            .changeGrowth(val);
                                                        mainController
                                                            .growthStateMode(
                                                                false);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 200,
                                                    child: RadioListTile(
                                                      title: const Text(
                                                          "Logistic"),
                                                      value: "logistic",
                                                      groupValue: mainController
                                                          .growth.value,
                                                      onChanged: (val) {
                                                        mainController
                                                            .changeGrowth(val);
                                                        mainController
                                                            .growthStateMode(
                                                                true);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Visibility(
                                                visible: mainController
                                                    .growthState.value,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: AutoSizeText(
                                                              "cap :           "),
                                                        ),
                                                        SizedBox(
                                                          width: 50.0,
                                                          height: 10.0,
                                                          child: TextField(
                                                            controller:
                                                                mainController
                                                                    .textFieldController6,
                                                            // decoration: const InputDecoration(
                                                            //     labelText: "Enter your number"),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
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
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: AutoSizeText(
                                                              "floor :           "),
                                                        ),
                                                        SizedBox(
                                                          width: 50.0,
                                                          height: 10.0,
                                                          child: TextField(
                                                            controller:
                                                                mainController
                                                                    .textFieldController7,
                                                            // decoration: const InputDecoration(
                                                            //     labelText: "Enter your number"),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
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
                                      "algo": mainController
                                          .currentPredictModel1.value,
                                      "p": mainController
                                          .textFieldController18.text,
                                      "d": mainController
                                          .textFieldController19.text,
                                      "q": mainController
                                          .textFieldController20.text,
                                      "train_perc": mainController
                                          .textFieldController21.text,
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
            ],
          ),
        ),
      ),
    );
  }
}
