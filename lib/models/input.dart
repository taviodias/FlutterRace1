import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme/app_text.dart';
import 'theme/app_theme.dart';

class InputText extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final void Function(String)? onChange;
  final String? Function(String)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const InputText({
    Key? key,
    required this.label,
    required this.hint,
    this.obscure = false,
    this.onChange,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label).label,
        SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscure,
          style: AppTheme.textStyles.input,
          onChanged: onChange,
          validator: (value) {
            if (validator != null) {
              return validator!(value ?? '');
            }
          },
          decoration: InputDecoration(
            hintStyle: AppTheme.textStyles.hint,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppTheme.colors.border),
            ),
          ),
        ),
      ],
    );
  }
}
