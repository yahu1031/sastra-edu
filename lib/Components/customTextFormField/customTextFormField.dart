import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../misc/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool autovalidate;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final String initialValue;
  final Widget suffixIcon;
  final FocusNode focusNode;

  CustomTextFormField({
    @required this.onChanged,
    @required this.labelText,
    this.validator,
    this.autovalidate = false,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.initialValue,
    this.suffixIcon,
    this.focusNode,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool wasNotEdited = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String _input) {
        widget.onChanged(_input);

        if (wasNotEdited) wasNotEdited = false;
      },
      validator: widget.validator,
      autovalidate: wasNotEdited == true ? false : widget.autovalidate,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.headline6,
        helperText: '',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.lightBlueAccent,
          ),
        ),
        suffixIcon: widget.suffixIcon,
      ),
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
    );
  }
}
