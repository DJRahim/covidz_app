import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/home_page_admin.dart';
import 'package:covidz/tools/api_requests.dart';
import 'package:covidz/tools/auth.dart';
import 'package:covidz/tools/main_controller.dart';
import 'package:covidz/tools/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthPage extends GetView<MainController> {
  AuthPage({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();
  final DioClient _client = DioClient();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/corona2.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "COVI",
                      style: TextStyle(fontSize: 37),
                    ),
                    Text(
                      "DZ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 37,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: Get.width * 0.35,
                  height: 50.0,
                  child: const TabBar(
                    tabs: [
                      Tab(text: "Connexion"),
                      Tab(text: "Inscription"),
                    ],
                    labelColor: Color.fromARGB(255, 0, 0, 0),
                    unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: Get.width * 0.32,
                  height: 300.0,
                  child: TabBarView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.2,
                            height: 30.0,
                            child: TextField(
                              controller: controller.textFieldController13,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(2.0),
                                  labelText: "  email"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: Get.width * 0.2,
                            height: 30.0,
                            child: TextField(
                              controller: controller.textFieldController14,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(2.0),
                                  labelText: "  mot de passe"),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 43),
                          ElevatedButton(
                            onPressed: () async {
                              List res = await authController.login(
                                controller.textFieldController13.text.trim(),
                                controller.textFieldController14.text.trim(),
                              );
                              if (res[0] == 'success') {
                                box.write(
                                  "email",
                                  controller.textFieldController13.text.trim(),
                                );
                                box.write(
                                  "passwd",
                                  controller.textFieldController14.text.trim(),
                                );
                                String res = await _client.getToken();
                                controller.resetAuthPage();

                                if (res == "normal") {
                                  Get.offAll(HomeNew());
                                } else {
                                  if (res == "admin") {
                                    Get.offAll(HomeAdmin());
                                  } else {
                                    Get.snackbar(
                                      "Erreur d'authentification",
                                      "probleme de generation du token",
                                      snackPosition: SnackPosition.BOTTOM,
                                      isDismissible: true,
                                    );
                                  }
                                }
                              } else {
                                Get.snackbar(
                                  "Erreur d'authentification",
                                  res[1],
                                  snackPosition: SnackPosition.BOTTOM,
                                  isDismissible: true,
                                );
                              }
                            },
                            child: const Text("Se connecter"),
                          ),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () async {
                              if (controller.textFieldController13.text
                                      .trim() ==
                                  "") {
                                Get.snackbar(
                                  "Erreur d'authentification",
                                  "email invalide.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  isDismissible: true,
                                );
                              } else {
                                List res = await authController.resetPassword(
                                  controller.textFieldController13.text.trim(),
                                );
                                if (res[0] == 'success') {
                                  Get.snackbar(
                                    "Reinitialisation du mot de passe",
                                    res[1],
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                  );
                                } else {
                                  Get.snackbar(
                                    "Erreur d'authentification",
                                    res[1],
                                    snackPosition: SnackPosition.BOTTOM,
                                    isDismissible: true,
                                  );
                                }
                              }
                            },
                            child: Text("Mot de passe oublié ?"),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.2,
                            height: 30.0,
                            child: TextField(
                              controller: controller.textFieldController15,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(2.0),
                                  labelText: "  nom et prenom"),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: Get.width * 0.2,
                            height: 30.0,
                            child: TextField(
                              controller: controller.textFieldController16,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(2.0),
                                  labelText: "  email"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: Get.width * 0.2,
                            height: 30.0,
                            child: TextField(
                              controller: controller.textFieldController17,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(2.0),
                                  labelText: "  mot de passe"),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 43),
                          ElevatedButton(
                            onPressed: () async {
                              List res = await _client.signup(
                                "signup",
                                {
                                  "name": controller.textFieldController15.text
                                      .trim(),
                                  "email": controller.textFieldController16.text
                                      .trim(),
                                  "passwd": controller
                                      .textFieldController17.text
                                      .trim(),
                                },
                              );
                              if (res[1] == 200) {
                                Get.snackbar(
                                  "Demande d'inscription envoyée",
                                  "Verifier votre email pour un message de confirmation",
                                  snackPosition: SnackPosition.BOTTOM,
                                  isDismissible: true,
                                );
                              } else {
                                Get.snackbar(
                                  "Erreur d'inscription",
                                  res[0]["message"],
                                  snackPosition: SnackPosition.BOTTOM,
                                  isDismissible: true,
                                );
                              }
                            },
                            child: const Text("S'inscrire"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
