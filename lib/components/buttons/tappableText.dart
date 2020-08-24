/*
 * Name: tappableText
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

import '../customInkWell.dart';

class TappableText extends StatelessWidget {
  final String data;
  final GestureTapCallback onTap;

  TappableText(this.data, {@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          data,
          style:
              subtitle1HighlightTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
