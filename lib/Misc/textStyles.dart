import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';

// Todo: maybe increase body font size

/// TextStyles ///
///
/// Body1
final TextStyle body1TextStyle = GoogleFonts.notoSans(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kDarkColor,
);

final TextStyle body1HighlightTextStyle = body1TextStyle.copyWith(
  color: kHighlightColor,
);

final TextStyle body1GreyTextStyle = body1TextStyle.copyWith(
  color: kMiddleGrey,
);

/// Headline1
final TextStyle headline1TextStyle = GoogleFonts.montserrat(
  fontSize: 10 * SizeConfig.textMultiplier,
  fontWeight: FontWeight.w700,
  color: kDarkColor,
);

final TextStyle headline1HighlightTextStyle = headline1TextStyle.copyWith(
  color: kHighlightColor,
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

/// Headline3
final TextStyle headline3TextStyle = GoogleFonts.montserrat(
  fontSize: 40,
  fontWeight: FontWeight.w700,
  color: kDarkColor,
);

final TextStyle headline3HighlightTextStyle = headline3TextStyle.copyWith(
  color: kHighlightColor,
);

final TextStyle headline3ThinTextStyle = GoogleFonts.notoSans(
  fontSize: 40,
  color: kDarkColor,
);

/// Headline4
final TextStyle headline4TextStyle = GoogleFonts.montserrat(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: kDarkColor,
);

final TextStyle headline4HighlightTextStyle = headline4TextStyle.copyWith(
  color: kHighlightColor,
);

final TextStyle headline4GreyTextStyle = headline4TextStyle.copyWith(
  color: kMiddleGrey,
);

/// Subtitle1
final TextStyle subtitle1TextStyle = GoogleFonts.montserrat(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final TextStyle subtitle1HighlightTextStyle = subtitle1TextStyle.copyWith(
  color: kHighlightColor,
);

final TextStyle subtitle1LightTextStyle = subtitle1TextStyle.copyWith(
  color: kLightColor,
);

final TextStyle subtitle1GreyTextStyle = subtitle1TextStyle.copyWith(
  color: kDarkGrey,
);

/// ButtonLabel
final TextStyle buttonLabelTextStyle = GoogleFonts.notoSans(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: Colors.white,
);

final TextStyle tabTitleTextStyle = GoogleFonts.notoSans(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);
