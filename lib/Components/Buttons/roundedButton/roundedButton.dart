import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../textStyles.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;

  const RoundedButton({@required this.onPressed, @required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.lightBlueAccent,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            this.labelText,
            style: buttonLabelTextStyle,
          ),
        ),
      ),
    );
  }
}
