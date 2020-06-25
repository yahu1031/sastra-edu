import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSize appBar;
  final Widget body;
  final bool resizeToAvoidBottomPadding;

  const CustomScaffold({
    this.resizeToAvoidBottomPadding = false,
    this.appBar,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
      backgroundColor: kLightColor,
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
