import 'package:flutter/material.dart';
import 'package:magic_slides/routes/routes.dart';
import 'package:magic_slides/views/auth/login_view.dart';
import 'package:magic_slides/views/auth/signup_view.dart';
import 'package:magic_slides/views/home/home_view.dart';
import 'package:magic_slides/views/home/pdf_view.dart';
import 'package:magic_slides/views/splash_view.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case Routes.login:
            return LoginView();

          case Routes.signUp:
            return SignUpView();

          case Routes.home:
            return HomeView();

          case Routes.pdfView:
            final arguments = settings.arguments;
            return PdfView(arguments: arguments);

          default:
            return SplashView();
        }
      },
    );
  }
}
