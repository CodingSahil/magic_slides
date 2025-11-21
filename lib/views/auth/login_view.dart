import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_slides/controller/auth/login_controller.dart';
import 'package:magic_slides/routes/routes.dart';
import 'package:magic_slides/utils/extenstions/integer_extenstion.dart';
import 'package:magic_slides/utils/theme-text/text-style.dart';
import 'package:magic_slides/utils/widgets/common_button.dart';
import 'package:magic_slides/utils/widgets/label_text_fields.dart';
import 'package:magic_slides/utils/widgets/loader.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginController loginController;
  late final TextEditingController emailOrMobileController;
  late final TextEditingController passwordController;
  bool isError = false;

  @override
  void initState() {
    loginController = Get.find<LoginController>();
    loginController.getAllUsers();
    emailOrMobileController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        return loginController.loader.value
            ? Center(child: Loader())
            : Container(
                width: MediaQuery.widthOf(context),
                height: MediaQuery.heightOf(context),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextFormFieldsWithLabel(
                      textEditingController: emailOrMobileController,
                      hintText: "Email Or Mobile Number",
                      textInputType: TextInputType.url,
                      isError:
                          isError &&
                          (emailOrMobileController.text.isEmpty ||
                              int.tryParse(emailOrMobileController.text) == null &&
                                  !EmailValidator.validate(emailOrMobileController.text)),
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                    ),
                    25.height,
                    AppTextFormFieldsWithLabel(
                      textEditingController: passwordController,
                      hintText: "Password",
                      isError: isError && passwordController.text.isEmpty,
                      isPasswordField: true,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                    ),
                    50.height,
                    ClickablePrimaryButton(
                      label: "Login",
                      onTap: () async {
                        if (!loginController.buttonLoader.value) {
                          setState(() {
                            isError =
                                emailOrMobileController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                int.tryParse(emailOrMobileController.text) == null &&
                                    !EmailValidator.validate(emailOrMobileController.text);
                          });
                          debugLog(
                            "isError => $isError\ntryParse => ${int.tryParse(emailOrMobileController.text) == null}\nvalidate => ${!EmailValidator.validate(emailOrMobileController.text)}",
                          );
                          if (!isError) {
                            await loginController.loginUser(
                              context,
                              emailOrMobileNumber: emailOrMobileController.text,
                              password: passwordController.text,
                            );
                          }
                        }
                      },
                      loader: Loader(color: Theme.of(context).colorScheme.surface),
                      isLoader: loginController.buttonLoader.value,
                    ),
                    25.height,
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Get.toNamed(Routes.signUp);
                      },
                      child: AppTextTheme.text(
                        "Don't have a Account?",
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
