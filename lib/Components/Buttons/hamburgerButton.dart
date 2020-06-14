import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class HamburgerButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HamburgerButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.menu,
        color: kHighlightColor,
      ),
    );
  }
}
