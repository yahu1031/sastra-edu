/*
 * Name: textStyles
 * Use:
 * TODO:    - Add Use of this file
            - go over text styles
            - maybe increase body font size
            - re-evaluate headings
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';

import 'customColors.dart';

/// TextStyles ///
///
/// Body1
final TextStyle body1TextStyle = GoogleFonts.lexendDeca(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: CustomColors.darkColor,
);

final TextStyle body1HighlightTextStyle = body1TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

final TextStyle body1GreyTextStyle = body1TextStyle.copyWith(
  color: CustomColors.middleGrey,
);

/// Headline1
final TextStyle headline1TextStyle = GoogleFonts.lexendDeca(
  fontSize: SizeConfig.textMultiplier * 11,
  fontWeight: FontWeight.w700,
  color: CustomColors.darkColor,
);

final TextStyle headline1HighlightTextStyle = headline1TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

/// Headline2
final TextStyle headline2TextStyle = GoogleFonts.lexendDeca(
  fontSize: 50,
  fontWeight: FontWeight.w700,
  color: CustomColors.darkColor,
);

final TextStyle headline2HighlightTextStyle = headline2TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

/// Headline3
final TextStyle headline3TextStyle = GoogleFonts.lexendDeca(
  fontSize: 40,
  fontWeight: FontWeight.w700,
  color: CustomColors.darkColor,
);

final TextStyle headline3HighlightTextStyle = headline3TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

final TextStyle headline3ThinTextStyle = GoogleFonts.lexendDeca(
  fontSize: 40,
  color: CustomColors.darkColor,
);

/// Headline4
final TextStyle headline4TextStyle = GoogleFonts.lexendDeca(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: CustomColors.darkColor,
);

final TextStyle headline4HighlightTextStyle = headline4TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

final TextStyle headline4GreyTextStyle = headline4TextStyle.copyWith(
  color: CustomColors.middleGrey,
);

/// Subtitle1
final TextStyle subtitle1TextStyle = GoogleFonts.lexendDeca(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final TextStyle subtitle1HighlightTextStyle = subtitle1TextStyle.copyWith(
  color: CustomColors.highlightColor,
);

final TextStyle subtitle1LightTextStyle = subtitle1TextStyle.copyWith(
  color: CustomColors.lightColor,
);

final TextStyle subtitle1GreyTextStyle = subtitle1TextStyle.copyWith(
  color: CustomColors.darkGrey,
);

/// ButtonLabel
final TextStyle buttonLabelTextStyle = GoogleFonts.lexendDeca(
  fontWeight: FontWeight.w700,
  fontSize: 20,
  color: CustomColors.lightColor,
);

final TextStyle tabTitleTextStyle = GoogleFonts.lexendDeca(
  fontSize: 18.0,
  fontWeight: FontWeight.w700,
);
