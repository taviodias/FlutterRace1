// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ta_caro/models/button.dart';
import 'package:ta_caro/models/create_account_controller.dart';
import 'package:ta_caro/models/input.dart';
import 'package:ta_caro/models/theme/app_theme.dart';
import 'package:validators/validators.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final controller = CreateAccountController();

  @override
  void initState() {
    controller.addListener(() {
      controller.state.when(
          success: (value) => Navigator.pop(context),
          loading: () => print('loading...'),
          error: (message, _) => print(message),
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
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 38,
                ),
                Text('Criando uma conta', style: AppTheme.textStyles.title),
                SizedBox(
                  height: 10,
                ),
                Text('Mantenha seus gastos em dia',
                    style: AppTheme.textStyles.subtitle),
                SizedBox(
                  height: 38,
                ),
                InputText(
                  label: 'Nome',
                  hint: 'Digite seu nome completo',
                  onChange: (value) => controller.onChange(name: value),
                  validator: (value) =>
                      value.isNotEmpty ? null : 'Digite seu nome',
                ),
                SizedBox(height: 18),
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
                  onChange: (value) => controller.onChange(password: value),
                  obscure: true,
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
                    loading: () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                    orElse: () => Button(
                      label: 'Criar conta',
                      onTap: () {
                        controller.create();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
