/*
 * Name: loadingDialog
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

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
                borderRadius: Dimensions.borderRadius,
                color: CustomColors.lightColor),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.highlightColor),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
