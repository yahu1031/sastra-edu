import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

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
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? kLightHighlightColor : null,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: kHighlightColor,
        onPressed: onPressed,
      ),
    );
  }
}
