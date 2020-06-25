import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';

class Heading extends StatelessWidget {
  final String text;
  final String text2;
  final String highlightText;

  const Heading({
    @required this.text,
    @required this.text2,
    @required this.highlightText,
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
          TextSpan(text: highlightText, style: headline3HighlightTextStyle),
        ],
      ),
    );
  }
}
