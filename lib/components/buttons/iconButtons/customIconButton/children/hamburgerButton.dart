/*
 Name: customBackButton
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/material.dart';

import '../customIconButton.dart';

class HamburgerButton extends StatelessWidget {
  final GestureTapCallback onPressed;

  const HamburgerButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: onPressed,
      icon: Icons.menu,
    );
  }
}
