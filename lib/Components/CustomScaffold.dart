import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSize appBar;
  final Widget body;

  const CustomScaffold({this.appBar, this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: kLightColor,
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
    );
  }
}
