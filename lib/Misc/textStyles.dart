import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/misc/constants.dart';

import '../Services/Responsive/size_config.dart';

/// TextStyles ///
///
/// Body1
final TextStyle body1TextStyle = GoogleFonts.notoSans(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kDarkColor,
);

final TextStyle body1HighlightTextStyle = body1TextStyle.copyWith(
  color: Colors.lightBlueAccent,
);

/// Headline1
final TextStyle headline1TextStyle = GoogleFonts.montserrat(
  fontSize: 100,
  fontWeight: FontWeight.w700,
  color: kDarkColor,
);

final TextStyle headline1HighlightTextStyle = headline1TextStyle.copyWith(
  color: Colors.lightBlueAccent,
);

/// Headline2
final TextStyle headline2TextStyle = GoogleFonts.montserrat(
  fontSize: 50,
  fontWeight: FontWeight.w700,
  color: kDarkColor,
);

final TextStyle headline2HighlightTextStyle = headline2TextStyle.copyWith(
  color: kHighlightColor,
);

/// Headline5
final TextStyle headline5TextStyle = GoogleFonts.montserrat(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: kDarkColor,
);

final TextStyle headline5HighlightTextStyle = headline5TextStyle.copyWith(
  color: kHighlightColor,
);

/// Headline6
final TextStyle headline6TextStyle = GoogleFonts.notoSans(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

final TextStyle headline6HighlightTextStyle = headline6TextStyle.copyWith(
  color: kHighlightColor,
);

/// Subtitle6
final TextStyle subtitle1TextStyle = GoogleFonts.notoSans(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final TextStyle subtitle1HighlightTextStyle = subtitle1TextStyle.copyWith(
  color: kHighlightColor,
);

/// ButtonLabel
final TextStyle buttonLabelTextStyle = GoogleFonts.notoSans(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: Colors.white,
);
