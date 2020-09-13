/*
 Name: passwordTextFormField
 Use:
 Todo:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/buttons/textFieldButton/textFieldButton.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/strings.dart';

import '../customTextFormField.dart';

class PasswordTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  PasswordTextFormField({
    @required this.onChanged,
    this.focusNode,
  });

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  bool wasNotEdited = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: widget.onChanged,
      labelText: Strings.passwordString,
      validator: (String _input) {
        if (_input.isEmpty) {
          return Strings.passwordFieldEmptyString;
        }
        return null;
      },
      autovalidate: true,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      suffixIcon: TextFieldButton(
        onPressed: () => setState(() {
          obscureText = !obscureText;
        }),
        highlightColor: Colors.blueAccent.withOpacity(.15),
        child: Icon(
          Icons.visibility,
          color: CustomColors.highlightColor,
        ),
      ),
      focusNode: widget.focusNode,
    );
  }
}
