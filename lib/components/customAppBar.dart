/*
 * Name: customAppBar
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';

import 'buttons/iconButtons/customIconButton/children/customBackButton.dart';

class CustomAppBar extends PreferredSize {
  final BuildContext context;

  final bool backButton;
  final Function onBackButtonPressed;
  final Color backButtonColor;
  final Widget leading;
  final Widget title;
  final bool isTranslucent;

  CustomAppBar(
    this.context, {
    this.backButton,
    this.onBackButtonPressed,
    this.backButtonColor,
    this.leading,
    this.title,
    this.isTranslucent = false,
  })  : assert(!(backButton != null && leading != null),
            ' You can\'t have a back button and a leading widget in an AppBar'),
        super(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: isTranslucent
                ? CustomColors.translucentLightColor
                : CustomColors.lightColor,
            leading: backButton == true
                ? CustomBackButton(
                    onPressed:
                        onBackButtonPressed ?? () => Navigator.pop(context),
                    color: backButtonColor,
                  )
                : (leading != null ? leading : null),
            title: title,
          ),
        );
}
