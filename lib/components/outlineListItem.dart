/*
 * Name: outlineListItem
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

enum ChapterType {
  main,
  sub,
  doubleSub,
}

class OutlineListItem extends StatefulWidget {
  final String title;
  final int page;
  final ChapterType chapterType;
  final PDFViewController pdfViewController;
  final List<OutlineListItem> children;

  OutlineListItem({
    Key key,
    @required this.title,
    @required this.page,
    @required this.chapterType,
    @required this.pdfViewController,
    this.children,
  }) : super(key: key);

  @override
  _OutlineListItemState createState() => _OutlineListItemState();
}

class _OutlineListItemState extends State<OutlineListItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: Dimensions.borderRadius,
            color: widget.chapterType == ChapterType.main ||
                    widget.chapterType == ChapterType.doubleSub
                ? CustomColors.veryLightGrey
                : null,
          ),
          child: InkWell(
            onTap: () {
              widget.pdfViewController.setPage(widget.page - 1);
              Navigator.pop(context);
            },
            borderRadius: Dimensions.borderRadius,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.title,
                      style: body1TextStyle,
                    ),
                  ),
                ),
                if (widget.children != null)
                  GestureDetector(
                    onTap: () {
                      if (_expanded) {
                        setState(() {
                          _expanded = false;
                        });
                      } else {
                        setState(() {
                          _expanded = true;
                        });
                      }
                    },
                    child: Container(
                      width: 60,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          width: 35,
                          height: 35,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: Dimensions.borderRadius,
                            color: CustomColors.lightGrey,
                          ),
                          child: RotatedBox(
                            quarterTurns: _expanded ? 2 : 0,
                            child: Icon(Icons.expand_more),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (widget.children != null && _expanded)
          Padding(
            padding: EdgeInsets.only(left: Dimensions.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
      ],
    );
  }
}
