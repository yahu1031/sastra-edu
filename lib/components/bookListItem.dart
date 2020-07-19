/*
 * Name: bookListItem
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
            - unify fonts
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/pdf.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/components/customInkWell.dart';

class BookListItem extends StatelessWidget {
  static final List<BookListItem> bookListItems = [];
  final Book book;

  factory BookListItem({@required Book book}) {
    for (BookListItem bookListItem in bookListItems) {
      if (bookListItem.book.id == book.id) {
        return bookListItem;
      }
    }

    final BookListItem newBook = BookListItem._internal(
      book: book,
    );
    bookListItems.add(newBook);
    return bookListItems.last;
  }

  BookListItem._internal({
    this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 75),
      margin: EdgeInsets.only(bottom: Dimensions.largePadding),
      child: CustomInkWell(
        onLongPressed: () {
          dialogs.downloadDialog(context, Strings.kDownloadTitle,
              'So, you would like to download "${book.name}" ?');
        },
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(book.name, book.url),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: Dimensions.borderRadius,
                color: CustomColors.veryLightGrey,
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: book.imgUrl,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.name,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.author + ", ",
                        style: GoogleFonts.poppins(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Edition - ${book.edition}",
                        style: GoogleFonts.poppins(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
