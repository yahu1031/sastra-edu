/*
 * Name: tappableSubtitle
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:sastra_ebooks/components/buttons/tappableText.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

class TappableSubtitle extends StatelessWidget {
  final String descriptionText;
  final String actionText;
  final GestureTapCallback onActionTap;

  const TappableSubtitle({
    @required this.descriptionText,
    @required this.actionText,
    @required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          descriptionText,
          style: subtitle1TextStyle,
        ),
        TappableText(
          actionText,
          onTap: onActionTap,
        )
      ],
    );
  }
}
