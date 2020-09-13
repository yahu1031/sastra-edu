/*
 Name: listItem
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

class ListItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  const ListItem({
    @required this.onPressed,
    @required this.title,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.padding - (Dimensions.padding / 2),
      ),
      child: InkWell(
        borderRadius: Dimensions.borderRadius,
        onTap: onPressed,
        child: Container(
          height: 50.0,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.padding - (Dimensions.padding / 2),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: onPressed != null
                    ? CustomColors.highlightColor
                    : CustomColors.middleGrey,
              ),
              SizedBox(width: 20.0),
              Text(
                title,
                style: onPressed != null
                    ? headline4TextStyle
                    : headline4GreyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
