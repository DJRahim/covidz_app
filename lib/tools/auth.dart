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
      () => AnimatedSplashScreen(
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
