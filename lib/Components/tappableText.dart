import 'package:flutter/cupertino.dart';

import '../textStyles.dart';

class TappableText extends StatelessWidget {
  final String data;
  final GestureTapCallback onTap;

  TappableText(this.data, {@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        data,
        style: subtitle1HighlightTextStyle,
      ),
    );
  }
}
