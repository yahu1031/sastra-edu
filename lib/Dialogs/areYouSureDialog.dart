import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/textStyles.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';

Future<bool> areYouSureDialog(
  BuildContext context, {
  @required String title,
  @required String description,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      bool choice = false;

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: headline3HighlightTextStyle,
        ),
        content: Text(
          description,
          style: body1TextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.lightBlue),
            ),
          ),
        ],
      );
    },
  );
}
