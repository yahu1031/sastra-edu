import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/textFieldButton/textFieldButton.dart';

import '../../../misc/constants.dart';
import '../customTextFormField.dart';

class PasswordTextFormField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  PasswordTextFormField({@required this.onChanged});

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  FocusNode focusNode;
  bool obscureText = true;
  bool wasNotEdited = true;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: widget.onChanged,
      labelText: kPasswordString,
      validator: (String _input) {
        if (_input.isEmpty) {
          return kPasswordFieldEmptyString;
        }
        return null;
      },
      autovalidate: true,
      keyboardType: TextInputType.number,
      obscureText: obscureText,
      //initialValue: '10111999',
      suffixIcon: TextFieldButton(
        onPressed: () => setState(() {
          obscureText = !obscureText;
        }),
        highlightColor: focusNode.hasFocus
            ? Colors.blueAccent.withOpacity(.15)
            : Colors.grey.withOpacity(.3),
        child: Icon(
          Icons.visibility,
          color: focusNode.hasFocus ? kHighlightColor : Colors.grey,
        ),
      ),
      focusNode: focusNode,
    );
  }
}
