import 'package:get/get.dart';
import 'package:magic_slides/controller/auth/login_controller.dart';
import 'package:magic_slides/controller/auth/sign_up_controller.dart';
import 'package:magic_slides/controller/home/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => HomeController());
  }
}
