/*
 * Name: regNumTextFormField
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/strings.dart';

import '../customTextFormField.dart';

class RegNumTextFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RegNumTextFormField({
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onChanged,
      hint: Strings.regNumString,
      onDigit: true,
      isPassword: false,
      validator: (String _input) {
        if (_input.isEmpty) {
          return Strings.regNumFieldEmptyString;
        }
        return null;
      },
      textLimit: 9,
    );
  }
}
