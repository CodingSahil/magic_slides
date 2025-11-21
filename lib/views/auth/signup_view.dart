import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_slides/controller/auth/sign_up_controller.dart';
import 'package:magic_slides/utils/extenstions/integer_extenstion.dart';
import 'package:magic_slides/utils/widgets/common_button.dart';
import 'package:magic_slides/utils/widgets/label_text_fields.dart';
import 'package:magic_slides/utils/widgets/loader.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final SignUpController signUpController;
  late final TextEditingController emailController;
  late final TextEditingController mobileNumberController;
  late final TextEditingController passwordController;
  bool isError = false;

  @override
  void initState() {
    signUpController = Get.find<SignUpController>();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        width: MediaQuery.widthOf(context),
        height: MediaQuery.heightOf(context),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextFormFieldsWithLabel(
              textEditingController: emailController,
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              isError:
                  isError &&
                  (emailController.text.isEmpty ||
                      (emailController.text.isNotEmpty && !EmailValidator.validate(emailController.text))),
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                setState(() {});
              },
            ),
            25.height,
            AppTextFormFieldsWithLabel(
              textEditingController: mobileNumberController,
              hintText: "Mobile Number",
              textInputType: TextInputType.phone,
              isError:
                  isError &&
                  (mobileNumberController.text.isEmpty ||
                      (mobileNumberController.text.isNotEmpty && mobileNumberController.text.length > 10)),
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                setState(() {});
              },
            ),
            25.height,
            AppTextFormFieldsWithLabel(
              textEditingController: passwordController,
              hintText: "Password",
              isPasswordField: true,
              isError: isError && (passwordController.text.isEmpty || (passwordController.text.isNotEmpty && passwordController.text.length > 7)),
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                setState(() {});
              },
            ),
            50.height,
            Obx(
              () => ClickablePrimaryButton(
                label: "Sign Up",
                onTap: () async {
                  if (!signUpController.buttonLoader.value) {
                    setState(() {
                      isError =
                          emailController.text.isEmpty ||
                          mobileNumberController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          (mobileNumberController.text.isNotEmpty && mobileNumberController.text.length > 10) ||
                          (emailController.text.isNotEmpty && !EmailValidator.validate(emailController.text));
                          (passwordController.text.isNotEmpty && passwordController.text.length > 7);
                    });

                    if (!isError) {
                      await signUpController.createUser(
                        emailID: emailController.text,
                        mobileNumber: mobileNumberController.text,
                        password: passwordController.text,
                      );
                    }
                  }
                },
                loader: Loader(color: Theme.of(context).colorScheme.surface),
                isLoader: signUpController.buttonLoader.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
