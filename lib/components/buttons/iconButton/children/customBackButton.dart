/*
 * Name: customBackButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';

import '../customIconButton.dart';

class CustomBackButton extends StatelessWidget {
  final GestureTapCallback onPressed;

  const CustomBackButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: Icons.arrow_back_ios,
    );
  }
}
