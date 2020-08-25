/*
 * Name: dialogs
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

import '../services/images.dart';

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
            borderRadius: Dimensions.borderRadius,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.blue),
          ),
          content: Text(
            body,
            style:
                GoogleFonts.notoSans(fontSize: 18, fontWeight: FontWeight.w500),
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
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> serviceDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
          ),
          title: Center(
            child: Text(
              '',
            ),
          ),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  Images.service,
                  height: 200.0,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> fetchDataError(
    BuildContext context,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
          ),
          title: Text(''),
          content: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  Images.fetchError,
                  height: 200.0,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> codingDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
          ),
          title: Center(
            child: Text(
              '',
            ),
          ),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset(
                Images.coding,
                height: 150.0,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TyperAnimatedTextKit(
                  text: [
                    "Sorry, we are currently coding your Classroom .",
                  ],
                  textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                  speed: Duration(milliseconds: 100),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> notFoundDialog(
    BuildContext context,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
          ),
          title: Center(
            child: Text(
              '',
            ),
          ),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset(
                Images.notfound,
                height: 100.0,
              )),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: TyperAnimatedTextKit(
                  text: [
                    "Sorry, we haven't designed this yet 😅.",
                  ],
                  textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                  speed: Duration(milliseconds: 100),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<bool> areYouSureDialog(
    BuildContext context, {
    @required String title,
    @required String description,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: Dimensions.borderRadius,
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
}
