/*
 Name: largeHeading
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

enum HeadingSize { large, extraLarge }

class LargeHeading extends StatelessWidget {
  final String text;
  final String highlightText;
  final HeadingSize size;

  const LargeHeading(
      {@required this.text, @required this.highlightText, @required this.size});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: size == HeadingSize.extraLarge
                ? headline1TextStyle
                : headline2TextStyle,
          ),
          TextSpan(
            text: highlightText,
            style: size == HeadingSize.extraLarge
                ? headline1HighlightTextStyle
                : headline2HighlightTextStyle,
          ),
        ],
      ),
    );
  }
}
