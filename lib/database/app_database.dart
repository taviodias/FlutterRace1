import 'package:ta_caro/database/supabase_database.dart';
import 'package:ta_caro/models/user.dart';

abstract class AppDatabase {
  static final AppDatabase instance = SupabaseDatabase();
  void init();
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> createAccount({
    required String name,
    required String email,
    required String password,
  });
}
