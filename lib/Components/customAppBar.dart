import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class CustomAppBar extends PreferredSize {
  final bool backButton;
  final Widget leading;
  final Widget title;
  final BuildContext context;

  // ignore: missing_required_param
  CustomAppBar(this.context, {this.backButton, this.leading, this.title})
      : assert(!(backButton != null && leading != null),
            ' You can\'t have a back button and a leading widget in an AppBar'),
        super(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: kLightColor,
            leading: backButton == true
                ? IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kHighlightColor,
                    ),
                  )
                : (leading != null ? leading : null),
            title: title,
          ),
        );
}
