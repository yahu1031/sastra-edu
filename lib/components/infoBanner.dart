import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';
import 'package:sastra_ebooks/Services/paths.dart';

// Todo: - decide if shadow or not

class InfoBanner extends StatelessWidget {
  final String message;

  InfoBanner({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage(
            Images.read,
          ),
        ),
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              message,
              style: subtitle1GreyTextStyle.copyWith(
                  color: subtitle1GreyTextStyle.color.withOpacity(.8)),
            )),
      ),
    );
  }
}
