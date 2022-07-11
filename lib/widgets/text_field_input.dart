import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final name;
  final bool IsPass;
  final Icon icon;
  final TextInputType textInputType;
  const TextFieldInput({Key? key,required this.name, required this.icon, required this.textInputType, required this.IsPass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: name,
        filled: true,
      ),
      keyboardType: textInputType,
      obscureText: IsPass,
    );
  }
}
