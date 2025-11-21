import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magic_slides/client_service/storage_keys.dart';
import 'package:magic_slides/client_service/supabase_service/supabase_methods.dart';
import 'package:magic_slides/main.dart';
import 'package:magic_slides/model/user/user_model.dart';
import 'package:magic_slides/routes/routes.dart';
import 'package:magic_slides/utils/widgets/custom_snack_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  RxBool loader = false.obs;
  RxBool buttonLoader = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;

  Future<void> getAllUsers({bool isLoaderRequire = true}) async {
    if (isLoaderRequire) loader(true);
    userList.value = await SupabaseMethods.getAllUsers();
    log("userList: ${jsonEncode(userList.map((element) => element.toJson(),).toList())}");
    if (isLoaderRequire) loader(false);
  }

  Future<void> loginUser(BuildContext context, {required String emailOrMobileNumber, required String password}) async {
    buttonLoader(true);
    await getAllUsers(isLoaderRequire: false);
    await Future.delayed(Duration(milliseconds: 500));
    if (userList.value.any(
          (element) =>
      (element.email.toLowerCase() == emailOrMobileNumber.toLowerCase() || element.mobileNumber == emailOrMobileNumber) &&
          element.password == password,
    )) {
      print("Object Found");
      UserModel userModel = userList.value.firstWhere(
            (element) =>
        (element.email.toLowerCase() == emailOrMobileNumber.toLowerCase() || element.mobileNumber == emailOrMobileNumber) &&
            element.password == password,
      );
      await initializers.getStorage.write(StorageKeys.user, jsonEncode(userModel.toJson()));
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      errorSnackBar(context: context, title: "User Not Found");
    }
    buttonLoader(false);
  }
}
