/*
 Name: infoBanner
 Use:
 Todo:    - Add Use of this file

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/images.dart';

class InfoBanner extends StatelessWidget {
  final String message;

  InfoBanner({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: Dimensions.borderRadius,
      ),
      child: Container(
        padding: const EdgeInsets.only(right: Dimensions.padding),
        child: Row(
          children: <Widget>[
            Image.asset(
              Images.read,
            ),
            Expanded(
              child: Center(
                child: Text(
                  message,
                  style: subtitle1TextStyle.copyWith(
                      color: CustomColors.darkColor.withOpacity(.6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
