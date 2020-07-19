/*
 * Name: floatingIconButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class FloatingIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;

  FloatingIconButton({@required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      elevation: Dimensions.elevation,
      borderRadius: Dimensions.borderRadius,
      child: InkWell(
        borderRadius: Dimensions.borderRadius,
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.largePadding,
            vertical: Dimensions.smallPadding,
          ),
          child: Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
