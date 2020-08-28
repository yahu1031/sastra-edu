/*
 * Name: bookmarkListItem
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/pdf.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

import 'bookListItem.dart';

class BookmarkListItem extends StatefulWidget {
  final Book book;
  final List bookmarks;

  const BookmarkListItem({Key key, this.book, this.bookmarks})
      : super(key: key);

  @override
  _BookmarkListItemState createState() => _BookmarkListItemState();
}

class _BookmarkListItemState extends State<BookmarkListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BookListItem(
          book: widget.book,
          setStateParent: setState,
        ),
        SizedBox(
          height: Dimensions.smallPadding,
        ),
        for (int i = 0; i < widget.bookmarks.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PdfViewerPage.id, arguments: {
                      'book': widget.book,
                      'page': widget.bookmarks[i]['page']
                    });
                  },
                  borderRadius: Dimensions.borderRadius,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.bookmarks[i]['name']}',
                          style: subtitle1TextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.bookmarks[i]['page']} - ${widget.bookmarks[i]['chapter']}',
                          style: body1TextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!(i == widget.bookmarks.length - 1)) Divider(),
              if (i == widget.bookmarks.length - 1)
                SizedBox(
                  height: 2.5,
                ),
            ],
          ),
      ],
    );
  }
}
