/*
 * Name: customIconButton
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;

  const CustomIconButton({@required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100),
      child: Icon(
        icon,
        color: CustomColors.highlightColor,
      ),
    );
    ;
  }
}
