import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:shimmer/shimmer.dart';

class AppTitle extends StatelessWidget {
  final String title;
  AppTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue[500],
      highlightColor: kHighlightColor,
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
