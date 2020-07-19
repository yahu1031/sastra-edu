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

  const CustomInkWell({@required this.onPressed, @required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Dimensions.borderRadius,
      child: child,
    );
  }
}
