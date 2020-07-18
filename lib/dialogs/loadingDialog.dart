import 'package:flutter/material.dart';

import '../misc/constants.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: kLightColor),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(kHighlightColor),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
