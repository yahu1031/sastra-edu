/*
 Name: customIconButton
 Use: 
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final Color color;

  const CustomIconButton({
    @required this.onPressed,
    @required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Icon(
        icon,
        color: color ?? CustomColors.highlightColor,
      ),
    );
  }
}
