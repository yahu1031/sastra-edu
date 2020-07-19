/*
 * Name: customAppBar
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';

import 'buttons/iconButton/children/customBackButton.dart';

class CustomAppBar extends PreferredSize {
  final bool backButton;
  final Function onBackButtonPressed;
  final Widget leading;
  final Widget title;
  final BuildContext context;
  final Color backgroundColor;

  CustomAppBar(this.context,
      {this.backButton,
      this.onBackButtonPressed,
      this.leading,
      this.title,
      this.backgroundColor = CustomColors.lightColor})
      : assert(!(backButton != null && leading != null),
            ' You can\'t have a back button and a leading widget in an AppBar'),
        super(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: backgroundColor,
            leading: backButton == true
                ? CustomBackButton(
                    onPressed:
                        onBackButtonPressed ?? () => Navigator.pop(context),
                  )
                : (leading != null ? leading : null),
            title: title,
          ),
        );
}
