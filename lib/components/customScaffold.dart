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
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Color backgroundColor;
  final Widget body;

  const CustomScaffold({
    this.resizeToAvoidBottomPadding = true,
    this.safeAreaTop = true,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      backgroundColor: backgroundColor ?? CustomColors.lightColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: SafeArea(
        top: safeAreaTop,
        bottom: false,
        child: body,
      ),
    );
  }
}
