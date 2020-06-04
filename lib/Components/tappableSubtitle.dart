import 'package:flutter/cupertino.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';

import '../misc/textStyles.dart';

class TappableSubtitle extends StatelessWidget {
  final String descriptionText;
  final String actionText;
  final GestureTapCallback onActionTap;

  const TappableSubtitle(
      {@required this.descriptionText,
      @required this.actionText,
      @required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          descriptionText,
          style: subtitle1TextStyle,
        ),
        SizedBox(width: 10.0),
        TappableText(
          actionText,
          onTap: onActionTap,
        )
      ],
    );
  }
}
