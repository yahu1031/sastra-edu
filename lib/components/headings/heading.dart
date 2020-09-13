/*
 Name: heading
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

class Heading extends StatelessWidget {
  final String text;
  final String text2;
  final String highlightText;
  final Color highlightColor;

  const Heading({
    this.text = '',
    this.text2,
    @required this.highlightText,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$text\n',
            style: headline3ThinTextStyle,
          ),
          TextSpan(
            text: text2,
            style: headline3TextStyle,
          ),
          TextSpan(
            text: highlightText,
            style: headline3HighlightTextStyle.copyWith(
                color: highlightColor ?? CustomColors.highlightColor),
          ),
        ],
      ),
    );
  }
}
