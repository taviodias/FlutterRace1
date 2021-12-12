import 'package:flutter/cupertino.dart';
import 'package:ta_caro/database/app_database.dart';
import 'package:ta_caro/models/state.dart';
import 'package:ta_caro/models/user.dart';

class CreateAccountController extends ChangeNotifier {
  AppState state = AppState.empty();

  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';

  void onChange({String? email, String? password, String? name}) {
    _email = email ?? _email;
    _password = password ?? _password;
    _name = name ?? _name;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> create() async {
    if (validate()) {
      try {
        update(AppState.loading());
        final response = await AppDatabase.instance
            .createAccount(email: _email, password: _password, name: _name);
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(AppState.error(e.toString()));
      }
    }
  }
}
