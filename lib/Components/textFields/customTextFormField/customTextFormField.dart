import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';

class CustomTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool autovalidate;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final String initialValue;
  final String hintText;
  final Widget suffixIcon;
  final String helperText;

  CustomTextFormField({
    @required this.onChanged,
    this.labelText,
    this.validator,
    this.hintText,
    this.autovalidate = false,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.initialValue,
    this.suffixIcon,
    this.helperText,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focusNode;
  bool wasNotEdited = true;
  String helperText;
  String hintText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

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
        decoration: InputDecoration(
          hintText: 'hintText',
          filled: true,
          fillColor: Colors.grey[200],
          labelText: widget.labelText,
          contentPadding: EdgeInsets.all(15.0),
          labelStyle: body1HighlightTextStyle,
          helperText: helperText,
          border: InputBorder.none,
          suffixIcon: widget.suffixIcon,
        ),
        //  focusNode: _focusNode,
        initialValue: widget.initialValue,
      ),
    );
  }
}
