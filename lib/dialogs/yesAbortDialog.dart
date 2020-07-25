/*
 * Name: yesAbortDialog
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/dialogs.dart';
import 'package:sastra_ebooks/books/downloadsPayment.dart';

Future<DialogAction> yesAbortDialog(
  BuildContext context,
  String title,
  String body,
) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.fromLTRB(50, 30, 50, 10),
        contentPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
        actionsPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.borderRadius,
        ),
        title: Text(
          title,
          // style: headline3HighlightTextStyle,
          style: subtitle1HighlightTextStyle,
        ),
        content: Text(
          body,
          style: body1TextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(DialogAction.abort),
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      );
    },
  );
}

Future<DialogAction> downloadDialog(
  BuildContext context,
  String title,
  String body,
) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.fromLTRB(50, 30, 50, 10),
        contentPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
        actionsPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
        shape: RoundedRectangleBorder(
          borderRadius: Dimensions.borderRadius,
        ),
        title: Text(
          title,
          // style: headline3HighlightTextStyle,
          style: subtitle1HighlightTextStyle,
        ),
        content: Text(
          body,
          style: body1TextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushNamed(
              context,
              DownloadPayment.id,
            ),
            child: const Text(
              'Download',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      );
    },
  );
}
