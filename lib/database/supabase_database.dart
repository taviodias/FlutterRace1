import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:ta_caro/models/user.dart';

import 'app_database.dart';

class SupabaseDatabase implements AppDatabase {
  late final SupabaseClient client;

  SupabaseDatabase() {
    init();
  }

  @override
  Future<UserModel> createAccount(
      {required String name,
      required String email,
      required String password}) async {
    final response = await client.auth.signUp(email, password);
    if (response.error == null) {
      final user = UserModel(id: response.user!.id, email: email, name: name);
      await createUser(user);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? 'Não foi possível criar usuário!');
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await client.auth.signIn(email: email, password: password);
    if (response.error == null) {
      final user = await getUser(response.user!.id);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? 'Não foi possível realizar login!');
    }
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment("SUPABASEURL"),
      const String.fromEnvironment("SUPABASEKEY"),
    );
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.from('user').insert(user.toMap()).execute();
    if (response.error == null) {
      return user;
    } else {
      throw Exception(
          response.error?.message ?? 'Não foi possível cadastrar usuário"');
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final response =
        await client.from('user').select().filter('id', 'eq', id).execute();
    if (response.error == null) {
      final user = UserModel.fromMap(response.data[0]);
      return user;
    } else {
      throw Exception('Não foi possível buscar o usuário!');
    }
  }
}
