/*
 * Name: customScaffold
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';

class CustomScaffold extends StatelessWidget {
  final bool resizeToAvoidBottomPadding;
  final bool safeAreaTop;
  final PreferredSize appBar;
  final Widget floatingActionButton;
  final Color backgroundColor;
  final Widget body;

  const CustomScaffold({
    this.resizeToAvoidBottomPadding = true,
    this.safeAreaTop = true,
    this.appBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      backgroundColor: backgroundColor ?? CustomColors.lightColor,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        top: safeAreaTop,
        child: body,
      ),
    );
  }
}
