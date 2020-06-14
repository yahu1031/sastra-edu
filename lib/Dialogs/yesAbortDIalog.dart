import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: headline3HighlightTextStyle,
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
