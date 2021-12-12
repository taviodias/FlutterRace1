import 'package:flutter/material.dart';
import 'package:ta_caro/models/button.dart';
import 'package:ta_caro/models/input.dart';
import 'package:ta_caro/models/login_controller.dart';
import 'package:ta_caro/models/theme/app_theme.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  void initState() {
    controller.addListener(() {
      controller.state.when(
          success: (value) =>
              Navigator.pushNamed(context, '/home', arguments: value),
          loading: () => print('loading...'),
          error: (message, e) => print(message),
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_tacaro.png',
                    width: 200,
                  ),
                  InputText(
                    label: 'E-mail',
                    hint: 'Digite seu e-mail',
                    onChange: (value) => controller.onChange(email: value),
                    validator: (value) =>
                        isEmail(value) ? null : 'Digite um e-mail válido',
                  ),
                  SizedBox(height: 18),
                  InputText(
                    label: 'Senha',
                    hint: 'Digite sua senha',
                    obscure: true,
                    onChange: (value) => controller.onChange(password: value),
                    validator: (value) => value.length >= 6
                        ? null
                        : 'Senha deve conter pelo menos 6 caracteres',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) => controller.state.when(
                      loading: () => Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                      orElse: () => Column(
                        children: [
                          Button(
                            label: 'Entrar',
                            onTap: () {
                              controller.login();
                            },
                          ),
                          SizedBox(
                            height: 58,
                          ),
                          Button(
                            label: 'Criar conta',
                            type: ButtonType.outline,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/login/create-account');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
