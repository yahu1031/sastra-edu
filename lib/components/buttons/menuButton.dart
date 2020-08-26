/*
 * Name: menuButton
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/buttons/dropDownButtun/dropDownButton.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool selected;

  const MenuButton({
    @required this.onPressed,
    @required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.smallPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? CustomColors.lightHighlightColor : null,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: CustomColors.highlightColor,
        onPressed: onPressed,
      ),
    );
  }
}
