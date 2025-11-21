import 'package:get/get.dart';
import 'package:magic_slides/client_service/supabase_service/supabase_methods.dart';
import 'package:magic_slides/model/user/user_model.dart';

class SignUpController extends GetxController {
  RxBool loader = false.obs;
  RxBool buttonLoader = false.obs;

  Future<void> createUser({required String emailID, required String mobileNumber, required String password}) async {
    buttonLoader(true);
    await SupabaseMethods.addUser(
      userModel: UserModel(mobileNumber: mobileNumber, email: emailID, password: password),
    );
    buttonLoader(false);
    Future.delayed(Duration(seconds: 1), () {
      Get.back();
    });
  }
}
