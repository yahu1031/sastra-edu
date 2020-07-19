/*
 * Name: roundedButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

import '../../../misc/textStyles.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;

  const RoundedButton({@required this.onPressed, @required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.padding),
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.borderRadius,
        ),
        color: Colors.lightBlueAccent,
        elevation: Dimensions.elevation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.padding),
          child: Text(
            this.labelText,
            style: buttonLabelTextStyle,
          ),
        ),
      ),
    );
  }
}
