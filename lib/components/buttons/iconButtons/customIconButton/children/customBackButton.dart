/*
 Name: customBackButton
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/material.dart';

import '../customIconButton.dart';

class CustomBackButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final Color color;

  const CustomBackButton({@required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: Icons.arrow_back_ios,
      color: color,
    );
  }
}
