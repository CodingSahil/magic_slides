import 'package:get_storage/get_storage.dart';
import 'package:magic_slides/controller/home/home_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class Initializers {
  const Initializers({required this.supabase, required this.getStorage, required this.homeController});

  final Supabase supabase;
  final GetStorage getStorage;
  final HomeController homeController;

  Initializers copyWith({Supabase? supabase, GetStorage? getStorage, HomeController? homeController}) {
    return Initializers(
      supabase: supabase ?? this.supabase,
      getStorage: getStorage ?? this.getStorage,
      homeController: homeController ?? this.homeController,
    );
  }
}
