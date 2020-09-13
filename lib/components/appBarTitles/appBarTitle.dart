/*
 Name: appBarTitle
 Use:
 Todo:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:shimmer/shimmer.dart';

// Todo: clean up fonts

class AppBarTitle extends StatelessWidget {
  final String title;
  AppBarTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue[500],
      highlightColor: CustomColors.highlightColor,
      child: Container(
        child: Text(
          title,
          style: GoogleFonts.pacifico(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
