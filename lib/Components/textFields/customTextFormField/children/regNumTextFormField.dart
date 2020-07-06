import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sastra_ebooks/Components/Buttons/textFieldButton/textFieldButton.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

import '../customTextFormField.dart';

class RegNumTextFormField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RegNumTextFormField({
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: onChanged,
      validator: (String _input) {
        if (_input.isEmpty) {
          return kRegNumFieldEmptyString;
        }
        return null;
      },
      autovalidate: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  PasswordTextFormField({@required this.onChanged});

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
      hintText: 'Password',
      onChanged: widget.onChanged,
      validator: (String _input) {
        if (_input.isEmpty) {
          return kPasswordFieldEmptyString;
        }
        return null;
      },
      autovalidate: true,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      //initialValue: '10111999',
      suffixIcon: TextFieldButton(
        onPressed: () => setState(() {
          obscureText = !obscureText;
        }),
        highlightColor: Colors.blueAccent.withOpacity(.15),
        child: Icon(
          Icons.visibility,
          color: kHighlightColor,
        ),
      ),
    );
  }
}
