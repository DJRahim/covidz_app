import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminUserList extends StatelessWidget {
  AdminUserList({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    mainController.getUsersList2();
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
                  itemCount: mainController.usersList2.length,
                  itemBuilder: (context, position) {
                    mainController.checkActiveUser(
                        mainController.usersList2[position]['email']);

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
                                    "Nom et prenom :  ${mainController.usersList2[position]['name']}",
                                    style: const TextStyle(fontSize: 22.0),
                                  ),
                                  Text(
                                    "Adresse e-mail :  ${mainController.usersList2[position]['email']}",
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
                                        "delete_user",
                                        {
                                          'email': mainController
                                              .usersList2[position]['email'],
                                        },
                                      );
                                      mainController.getUsersList2();
                                    },
                                    child: const Text("Supprimer"),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      var res = _client.acceptRejectRequest(
                                        mainController.activeUser.value
                                            ? "disable_user"
                                            : "activate_user",
                                        {
                                          'email': mainController
                                              .usersList2[position]['email'],
                                        },
                                      );
                                      mainController.getUsersList2();
                                    },
                                    child: mainController.activeUser.value
                                        ? const Text("Desactiver")
                                        : const Text("Activer"),
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
