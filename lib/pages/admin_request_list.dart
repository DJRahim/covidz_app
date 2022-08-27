import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRequestList extends StatelessWidget {
  AdminRequestList({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    mainController.getUsersList();
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 1000,
                height: 1000,
                child: ListView.builder(
                  itemCount: mainController.usersList.length,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 15),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nom et prenom :  ${mainController.usersList[position]['name']}",
                                    style: const TextStyle(fontSize: 22.0),
                                  ),
                                  Text(
                                    "Adresse e-mail :  ${mainController.usersList[position]['email']}",
                                    style: const TextStyle(fontSize: 22.0),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      var res = _client.acceptRejectRequest(
                                        "accept_user",
                                        {
                                          'email': mainController
                                              .usersList[position]['email'],
                                          'name': mainController
                                              .usersList[position]['name'],
                                          'passwd': mainController
                                              .usersList[position]['passwd'],
                                        },
                                      );
                                      mainController.getUsersList();
                                    },
                                    child: const Text("Accepter"),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      var res = _client.acceptRejectRequest(
                                        "reject_user",
                                        {
                                          'email': mainController
                                              .usersList[position]['email'],
                                        },
                                      );
                                      mainController.getUsersList();
                                    },
                                    child: const Text("Rejeter"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
