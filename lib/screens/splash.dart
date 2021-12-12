import 'package:flutter/material.dart';
import 'package:ta_caro/models/theme/app_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushNamed(context, '/login');
    });
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Center(
        child: Image.asset('assets/images/logo_tacaro.png'),
      ),
    );
  }
}
