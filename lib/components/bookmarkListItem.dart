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

class BookmarkListItem extends StatelessWidget {
  final Book book;
  final List bookmarks;

  const BookmarkListItem({Key key, this.book, this.bookmarks})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Dimensions.borderRadius,
        border: Border.all(
          width: 2,
          color: CustomColors.veryLightGrey,
        ),
//                        color: Colors.red,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BookListItem(
            book: book,
          ),
          SizedBox(
            height: Dimensions.smallPadding,
          ),
          for (int i = 0; i < bookmarks.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, PdfViewerPage.id,
                          arguments: {
                            'book': book,
                            'page': bookmarks[i]['page']
                          });
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => PdfViewerPage(
//                              book: book, page: bookmarks[i]['page']),
//                        ),
//                      );
                    },
                    borderRadius: Dimensions.borderRadius,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${bookmarks[i]['name']}',
                            style: subtitle1TextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${bookmarks[i]['page']} - ${bookmarks[i]['chapter']}',
                            style: body1TextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!(i == bookmarks.length - 1)) Divider(),
                if (i == bookmarks.length - 1)
                  SizedBox(
                    height: 2.5,
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
