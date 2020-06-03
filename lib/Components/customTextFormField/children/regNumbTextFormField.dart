import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../customTextFormField.dart';
import 'package:flutter/services.dart';

class RegNumTextFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RegNumTextFormField({
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: onChanged,
      labelText: kRegNumString,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],
      initialValue: '121003219',
    );
  }
}
