import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class CustomTextFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final String initialValue;
  final Widget suffixIcon;
  final FocusNode focusNode;

  CustomTextFormField(
      {@required this.onChanged,
      @required this.labelText,
      this.keyboardType,
      this.obscureText = false,
      this.inputFormatters,
      this.initialValue,
      this.suffixIcon,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline6,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      focusNode: focusNode,
      initialValue: initialValue,
    );
  }
}
