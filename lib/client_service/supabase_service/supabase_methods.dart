import 'package:magic_slides/client_service/supabase_service/supabase_path.dart';
import 'package:magic_slides/model/user/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMethods {
  static Future<List<UserModel>> getAllUsers() async {
    final future = await Supabase.instance.client.from(SupabasePath.users).select();
    final List<UserModel> users = (future as List<dynamic>)
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
        .toList();
    return users;
  }

  static Future<void> addUser({required UserModel userModel}) async {
    await Supabase.instance.client.from(SupabasePath.users).insert(userModel.toJson());
  }
}
