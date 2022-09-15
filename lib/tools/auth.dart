import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/home_page_admin.dart';
import 'package:covidz/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  final box = GetStorage();

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    var page;
    // box.write("intro", false);
    if (user == null) {
      page = AuthPage();
    } else {
      var type = box.read("user_type");
      if (type == "normal") {
        page = HomeNew();
      } else {
        page = HomeAdmin();
      }
    }
    Get.offAll(
      () => box.read("intro").runtimeType != Null && box.read("intro")
          ? AnimatedSplashScreen(
              nextScreen: page,
              splash: const Text(
                'COVIDZ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Color.fromARGB(255, 17, 70, 105),
                ),
              ),
              splashTransition: SplashTransition.fadeTransition,
              animationDuration: const Duration(milliseconds: 1500),
              duration: 2000,
              backgroundColor: Colors.white,
            )
          : Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/corona2.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'COVIDZ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          color: Color.fromARGB(255, 17, 70, 105),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        """Une application pour analyser et prédire la propagation du covid-19, 
et l'évolution de l'état de ses patients 
(pays ciblé : Algérie)""",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 220),
                      const Text(
                        """Application réalisée par 2 étudiants en BioInformatique : S. SOUKEUR et A. DJEDDOU
dans le cadre de leur projet de fin d'études de master,
supervisé par : Mme S. Boukhedouma
Département d'IA et de science des données
Faculté d'informatique
USTHB 
2021/2022""",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        onPressed: () {
                          box.write("intro", true);
                          Get.offAll(page);
                        },
                        icon: const Icon(
                          Icons.arrow_circle_right,
                        ),
                        iconSize: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  Future<List> login(String email, password) async {
    var res = [];
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      res.add('success');
      res.add('Connexion réussi');
    } on FirebaseAuthException catch (e) {
      res.add('fail');
      if (e.code == 'wrong-password') {
        res.add('mot de pass incorrect.');
      } else if (e.code == 'invalid-email') {
        res.add('email invalide.');
      } else if (e.code == 'user-not-found') {
        res.add("utilisateur n'existe pas.");
      } else if (e.code == "user-disabled") {
        res.add("utilisateur désactivé");
      }
    }
    return res;
  }

  Future<List> resetPassword(String email) async {
    var res = [];
    try {
      await auth.sendPasswordResetEmail(email: email);
      res.add('success');
      res.add('Verifier votre email.');
    } on FirebaseAuthException catch (e) {
      res.add('fail');
      if (e.code == 'invalid-email') {
        res.add('email invalide.');
      } else if (e.code == 'user-not-found') {
        res.add("utilisateur n'existe pas.");
      }
    }
    return res;
  }

  void signOut() async {
    await auth.signOut();
  }
}
