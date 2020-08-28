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
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/pdf.dart';
import 'package:sastra_ebooks/components/customInkWell.dart';
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/downloadBook.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';

class BookListItem extends StatefulWidget {
  static final List<BookListItem> bookListItems = [];
  final Function setStateParent;
  final Book book;
  final bool isFavoriteScreen;
  final bool isDownloadScreen;

  // factory BookListItem({@required Book book}) {
  //   for (BookListItem bookListItem in bookListItems) {
  //     if (bookListItem.book.isbn == book.isbn) {
  //       return bookListItem;
  //     }
  //   }

  //   final BookListItem newBook = BookListItem._internal(
  //     book: book,
  //   );
  //   bookListItems.add(newBook);
  //   return newBook;
  // }

  BookListItem({
    @required this.book,
    @required this.setStateParent,
    this.isFavoriteScreen,
    this.isDownloadScreen,
  });

  @override
  _BookListItemState createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  final GlobalKey key = GlobalKey();
  double height;
  bool isDownloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox box = key.currentContext.findRenderObject();

      height = box.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      constraints: BoxConstraints(minHeight: 75),
      child: CustomInkWell(
        onLongPressed: () {
          // Todo try to find solution which doesn't use lots of constant doubles
          double screenHeight = MediaQuery.of(context).size.height;
          RenderBox box = key.currentContext.findRenderObject();
          double bookListItemHeight = box.size.height;
          Offset position = box.localToGlobal(Offset.zero);

          // double dy = position.dy + bookListItemHeight - 24 + 10;
          double dy = position.dy + 57;

          if (dy >= screenHeight - 55 - 80)
            dy = position.dy - bookListItemHeight - 10;

          print(dy);
          print(screenHeight);
          showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(.1),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin: EdgeInsets.only(
                      left: position.dx,
                      right: Dimensions.padding,
                      top: dy,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: Dimensions.borderRadius,
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BookListItemAction(
                          onPressed: () {
                            if (FavoriteBooks.list.contains(widget.book.isbn)) {
                              setState(() {
                                FavoriteBooks.remove(widget.book.isbn);
                              });
                              widget.setStateParent(() {});
                              if (widget.isFavoriteScreen != null &&
                                  widget.isFavoriteScreen)
                                Navigator.pop(context);
                            } else {
                              setState(() {
                                FavoriteBooks.add(widget.book.isbn);
                              });
                              widget.setStateParent(() {});
                            }
                          },
                          icon: Icon(
                            FavoriteBooks.list.contains(widget.book.isbn)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                        BookListItemAction(
                          onPressed: () async {
                            if (DownloadBook.contains(widget.book.isbn)) {
                              await DownloadBook.remove(widget.book);
                              setState(() {});
                              widget.setStateParent(() {});
                              if (widget.isDownloadScreen != null &&
                                  widget.isDownloadScreen)
                                Navigator.pop(context);
                            } else {
                              setState(() {
                                isDownloading = true;
                              });
                              await DownloadBook.download(widget.book);
                              setState(() {
                                isDownloading = false;
                              });
                              widget.setStateParent(() {});
                            }

                            print('2');
                          },
                          loading: isDownloading,
                          icon: Icon(
                            DownloadBook.contains(widget.book.isbn)
                                ? Icons.cloud_download
                                : OMIcons.cloudDownload,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        onPressed: () {
          Navigator.pushNamed(context, PdfViewerPage.id,
              arguments: {'book': widget.book});
        },
        child: Container(
          key: key,
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
                    imageUrl: widget.book.imgUrl,
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
                      widget.book.title,
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
                          widget.book.author + ", ",
                          style: GoogleFonts.poppins(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Edition - ${widget.book.edition}",
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
            ],
          ),
        ),
      ),
    );
  }
}

class BookListItemAction extends StatelessWidget {
  final VoidCallback onPressed;
  final bool loading;
  final Icon icon;

  const BookListItemAction(
      {Key key, this.onPressed, this.icon, this.loading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: loading ? null : onPressed,
        borderRadius: BorderRadius.circular(45),
        child: Container(
          width: 45,
          height: 45,
          child: Center(
            child: loading
                ? Container(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : icon,
          ),
        ),
      ),
    );
  }
}

class BookListItemContent extends StatelessWidget {
  const BookListItemContent({
    Key key,
    @required this.book,
  }) : super(key: key);

  final Book book;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  book.title,
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
        ],
      ),
    );
  }
}
