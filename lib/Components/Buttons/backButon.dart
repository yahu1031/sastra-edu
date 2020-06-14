import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.arrow_back_ios,
        color: kHighlightColor,
      ),
    );
  }
}
