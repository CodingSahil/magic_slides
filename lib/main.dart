import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_slides/client_service/supabase_service/supabase_path.dart';
import 'package:magic_slides/controller/auth/login_controller.dart';
import 'package:magic_slides/controller/home/home_controller.dart';
import 'package:magic_slides/model/initializers.dart';
import 'package:magic_slides/routes/app_routes.dart';
import 'package:magic_slides/utils/bindings/bindings.dart';
import 'package:magic_slides/utils/theme-text/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late final Initializers initializers;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabaseUrl = SupabasePath.baseUrl;
  final supabaseAnonKey = SupabasePath.anonKey;

  Supabase? supabase = await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  initializers = Initializers(
    supabase: supabase,
    getStorage: GetStorage(),
    homeController: Get.put<HomeController>(HomeController()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme();
    return Obx(
      () => GetMaterialApp(
        title: 'MagicSlides',
        initialBinding: AppBinding(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: initializers.homeController.isDarkMode.value ? theme.dark() : theme.light(),
      ),
    );
  }
}
