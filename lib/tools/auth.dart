import 'package:covidz/assets/firebase_auth_constants.dart';
import 'package:covidz/home_page.dart';
import 'package:covidz/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => AuthPage());
    } else {
      Get.offAll(() => Home());
    }
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

  void signOut() async {
    await auth.signOut();
  }
}
