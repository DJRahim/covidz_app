import 'package:covidz/tools/main_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}
