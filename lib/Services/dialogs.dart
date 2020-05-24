import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DialogAction { abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body,
      ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title, style: TextStyle(color: Colors.blue),),
          content: Text(body, style: GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.w500),),
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
    return (action != null) ? action : DialogAction.abort;
  }
}