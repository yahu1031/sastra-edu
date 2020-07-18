import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kPadding - (kPadding / 2),
      ),
      margin: const EdgeInsets.only(bottom: kBottomPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(kRadius),
        onTap: onPressed,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kPadding - (kPadding / 2)),
          height: 50.0,
          child: Row(
            children: [
              Icon(
                icon,
                color: onPressed != null ? kHighlightColor : kMiddleGrey,
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
