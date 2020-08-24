/*
 * Name: roundedButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';

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

class CustomButton extends StatelessWidget {
  final Color buttonColor, textColor;
  final String text;
  final Function onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  const CustomButton({
    Key key,
    @required this.buttonColor,
    @required this.text,
    @required this.textColor,
    @required this.onPressed,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40 * SizeConfig.widthMultiplier,
      height: 50,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: FlatButton(
        color: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.lexendDeca(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
