import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final bool isPassword;
  final bool isReg;

  CustomTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    @required this.onChanged,
    this.isPassword = false,
    this.isReg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isReg ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          isReg ? LengthLimitingTextInputFormatter(9) : null,
        ],
      ),
    );
  }
}
