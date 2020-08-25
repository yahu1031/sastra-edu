/*
 * Name: yesAbortDialog
 * Use:
 * TODO:    - Add Use of this file
 */

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/downloadBook.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/dialogs.dart';

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
  Book book,
) async {
  bool loading = false;
  bool isDownloaded = false;
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/books/${book.id}.pdf';

  if (await File(filePath).exists())
    isDownloaded = true;
  else
    isDownloaded = false;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(50, 30, 50, 10),
            contentPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
            actionsPadding: EdgeInsets.fromLTRB(50, 10, 50, 30),
            shape: RoundedRectangleBorder(
              borderRadius: Dimensions.borderRadius,
            ),
            title: Text(
              isDownloaded ? Strings.kRemoveTitle : Strings.kDownloadTitle,
              style: subtitle1HighlightTextStyle,
            ),
            content: Text(
              isDownloaded
                  ? 'Would you like to remove "${book.name}" from your downloads?'
                  : 'Would you like to download "${book.name}" ?',
              style: body1TextStyle,
            ),
            actions: <Widget>[
              loading
                  ? CircularProgressIndicator()
                  : isDownloaded
                      ? FlatButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            await Future.delayed(Duration(milliseconds: 500));
                            await DownloadBook.remove(book);
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        )
                      : FlatButton(
                          onPressed: () async {
                            // Navigator.pushNamed(
                            //   context,
                            //   DownloadPayment.id,
                            // );
                            setState(() {
                              loading = true;
                            });

                            await Future.delayed(Duration(milliseconds: 500));
                            await DownloadBook.download(book);
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Download',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
            ],
          );
        },
      );
    },
  );
}
