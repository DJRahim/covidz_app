import 'package:covidz/assets/firebase_auth_constants.dart';
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
    return Scaffold(
      body: Center(
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
                  await _client.getToken();
                  Get.put(AuthController());
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
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
