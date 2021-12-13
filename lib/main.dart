import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ta_caro/models/user.dart';
import 'package:ta_caro/screens/Feed.dart';
import 'package:ta_caro/screens/profile.dart';
import 'screens/create_account.dart';
import 'screens/login.dart';
import 'screens/splash.dart';

import 'screens/home.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Race #1',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/home',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/login/create-account': (context) => CreateAccount(),
        '/home': (context) => Home(pages: [Feed(), Profile()]
            //user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
      },
    );
  }
}
