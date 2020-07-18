/*
 * Name: customBackButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/customColors.dart';

import 'customIconButton.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icons.menu,
    );
  }
}
