import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_slides/client_service/storage_keys.dart';
import 'package:magic_slides/main.dart';
import 'package:magic_slides/model/user/user_model.dart';
import 'package:magic_slides/routes/routes.dart';
import 'package:magic_slides/utils/extenstions/integer_extenstion.dart';
import 'package:magic_slides/utils/theme-text/text-style.dart';
import 'package:magic_slides/utils/widgets/loader.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 500));
      String? user = await initializers.getStorage.read(StorageKeys.user);
      log("user: $user");
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, user != null && user.isNotEmpty ? Routes.home : Routes.login);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Loader(),
            12.height,
            AppTextTheme.text(
              "Magic Slides",
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
