import 'package:flutter/cupertino.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

enum Heading { large, extraLarge }

class LargeHeading extends StatelessWidget {
  final String text;
  final String highlightText;
  final Heading size;

  const LargeHeading(
      {@required this.text, @required this.highlightText, @required this.size});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: text,
            style: size == Heading.extraLarge
                ? headline1TextStyle
                : headline2TextStyle,
          ),
          TextSpan(
            text: highlightText,
            style: size == Heading.extraLarge
                ? headline1HighlightTextStyle
                : headline2HighlightTextStyle,
          ),
        ],
      ),
    );
  }
}
