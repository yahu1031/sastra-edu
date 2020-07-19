/*
 * Name: helperCard
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/user.dart';

class DevCard extends StatelessWidget {
  final Developer helper;

  DevCard(this.helper);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: Dimensions.borderRadius,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(3, 3),
            blurRadius: 13,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: AssetImage(helper.picPath),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  helper.name,
                  style: GoogleFonts.poppins(
                      fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  helper.country,
                  style: GoogleFonts.poppins(
                      fontSize: 12.0, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
