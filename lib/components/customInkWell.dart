/*
 * Name: customInkWell
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class CustomInkWell extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onPressed;
  final GestureLongPressCallback onLongPressed;

  const CustomInkWell(
      {@required this.onPressed, @required this.child, this.onLongPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: onLongPressed,
        onTap: onPressed,
        borderRadius: Dimensions.borderRadius,
        child: child,
      ),
    );
  }
}
