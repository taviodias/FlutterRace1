import 'package:flutter/cupertino.dart';
import 'package:ta_caro/models/state.dart';

class BottomsheetController extends ChangeNotifier {
  AppState state = AppState.empty();

  final formKey = GlobalKey<FormState>();
  String _nome = '';
  String _price = '';
  String _date = '';

  void onChange({String? date, String? price, String? name}) {
    _nome = date ?? _nome;
    _price = price ?? _price;
    _date = date ?? _date;
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
      /* try {
        update(AppState.loading());
        final response = await AppDatabase.instance
            .createAccount(email: _nome, password: _price, name: _date);
        update(AppState.success<UserModel>(response));
      } catch (e) {
        update(AppState.error(e.toString()));
      } */
    }
  }
}
