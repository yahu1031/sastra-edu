import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focusNode;
  bool wasNotEdited = true;

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
        //  focusNode: _focusNode,
        initialValue: widget.initialValue,
      ),
    );
  }
}
