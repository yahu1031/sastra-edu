/*
 * Name: outlineListItem
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

class OutlineListItem extends StatelessWidget {
  final String title;
  final int page;
  final PDFViewController pdfViewController;
  final List<OutlineListItem> children;

  OutlineListItem({
    @required this.title,
    @required this.page,
    @required this.pdfViewController,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            pdfViewController.setPage(page - 1);
            Navigator.pop(context);
          },
          borderRadius: Dimensions.borderRadius,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: body1TextStyle,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (children != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          )
      ],
    );
  }
}
