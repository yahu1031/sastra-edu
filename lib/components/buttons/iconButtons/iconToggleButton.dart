/*
 Name: iconToggleButton
 Use: 
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class IconToggleButton extends StatelessWidget {
  final IconData activeIcon;
  final IconData disabledIcon;
  final VoidCallback onPressed;

  final Color activeColor;
  final Color disableColor;

  final bool isActive;

  IconToggleButton({
    @required this.activeIcon,
    @required this.disabledIcon,
    @required this.onPressed,
    @required this.isActive,
    this.activeColor,
    this.disableColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Dimensions.borderRadius,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Center(
          child: Icon(
            isActive ? activeIcon : disabledIcon,
            color: isActive ? activeColor : disableColor,
          ),
        ),
      ),
    );
  }
}
