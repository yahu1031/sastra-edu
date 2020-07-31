/*
 * Name: customTextFormField
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

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
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: TextFormField(
        onChanged: (String _input) {
          widget.onChanged(_input);

          if (wasNotEdited)
            setState(() {
              wasNotEdited = false;
            });
        },
        validator: widget.validator,
        autovalidate: wasNotEdited == true ? false : widget.autovalidate,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        inputFormatters: widget.inputFormatters,
        focusNode: widget.focusNode,
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
//          contentPadding: EdgeInsets.only(bottom: 50),
          hintText: widget.labelText,
          helperText: '',
          filled: true,
          fillColor: CustomColors.veryLightGrey,
          border: OutlineInputBorder(
            borderRadius: Dimensions.borderRadius,
            borderSide: BorderSide.none,
          ),
          suffixIcon: Padding(
              padding: EdgeInsets.only(bottom: 4), child: widget.suffixIcon),
        ),
      ),
    );
  }
}
