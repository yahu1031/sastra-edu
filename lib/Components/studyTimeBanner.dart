import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';
import 'package:sastra_ebooks/Services/paths.dart';

// Todo: - decide if shadow or not

class StudyTimeBanner extends StatelessWidget {
  final int studyTime;

  StudyTimeBanner({@required this.studyTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 150.0,
        maxWidth: 700.0,
        minWidth: 250.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.centerRight,
          image: AssetImage(
            Images.read,
          ),
        ),
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(20.0),
//        boxShadow: [
//          BoxShadow(color: kLightGrey, blurRadius: 10, offset: Offset(5, 5))
//        ],
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Study time today',
                style: subtitle1GreyTextStyle,
              ),
              SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  style: subtitle1LightTextStyle,
                  children: [
                    TextSpan(
                      text: studyTime.toString(),
                    ),
                    TextSpan(
                      text: '  minutes',
                      style: TextStyle(
                        color: kLightColor.withOpacity(.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
