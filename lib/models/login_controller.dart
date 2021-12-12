import 'package:flutter/cupertino.dart';
import 'package:ta_caro/database/app_database.dart';
import 'package:ta_caro/models/state.dart';
import 'package:ta_caro/models/user.dart';

class LoginController extends ChangeNotifier {
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void onChange({String? email, String? password}) {
    _email = email ?? _email;
    _password = password ?? _password;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> login() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response = await AppDatabase.instance
            .login(email: _email, password: _password);
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(AppState.error(e.toString()));
      }
    }
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }
}
