/*
 * Name: pdfViewBottomBar
 * Use: 
 * TODO:    - Add Use of this file
            - handle submited pageNumber > totalPages
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/iconToggleButton.dart';
import 'package:sastra_ebooks/home/screens/bookmark.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

import 'buttons/iconButtons/iconToggleButton.dart';

class PdfViewBottomBar extends StatefulWidget {
  final int totalPages, totalPageLength, currentPage;

  final String bookId;

  final bool pageBookmarked, isFavorite;

  final VoidCallback onBookmarkPressed, onFavoritePressed;

  final Function(String pageNumber) onPageNumberSubmit;
  final TextEditingController textEditingController;

  PdfViewBottomBar({
    @required this.totalPages,
    @required this.currentPage,
    @required this.bookId,
    @required this.pageBookmarked,
    @required this.isFavorite,
    @required this.onBookmarkPressed,
    @required this.onFavoritePressed,
    @required this.onPageNumberSubmit,
    this.textEditingController,
  }) : totalPageLength = totalPages.toString().length;

  @override
  _PdfViewBottomBarState createState() => _PdfViewBottomBarState();
}

class _PdfViewBottomBarState extends State<PdfViewBottomBar> {
  bool pageBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: kBottomNavigationBarHeight,
      color: CustomColors.translucentLightColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconToggleButton(
//            isActive: FavoriteBooks.list.contains(widget.bookId),
            onPressed: widget.onFavoritePressed,
            isActive: widget.isFavorite,
            activeIcon: Icons.favorite,
            disabledIcon: Icons.favorite_border,
//            onActivate: () {
//              FavoriteBooks.add(widget.bookId);
//              print(FavoriteBooks.list.length);
//            },
//            onDisable: () {
//              FavoriteBooks.remove(widget.bookId);
//              print(FavoriteBooks.list.length);
//            },
          ),
          IconToggleButton(
            onPressed: widget.onBookmarkPressed,
            isActive: widget.pageBookmarked,
            activeIcon: Icons.bookmark,
            disabledIcon: Icons.bookmark_border,
//            onActivate: () {
//              Bookmarks.add(widget.bookId, widget.currentPage);
//            },
//            onPressed: () {
//              Bookmarks.remove(widget.bookId, widget.currentPage);
//            },
          ),
          IconToggleButton(
            activeIcon: Icons.cloud_download,
            disabledIcon: OMIcons.cloudDownload,
            isActive: false,
            onPressed: () {},
          ),
          Row(
            children: <Widget>[
              Container(
                width: 10 * widget.totalPageLength.toDouble(),
                child: Theme(
                  data: ThemeData(
                    primaryColor: CustomColors.darkColor,
                  ),
                  child: TextField(
                    controller: widget.textEditingController,
                    onSubmitted: widget.onPageNumberSubmit,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        widget.totalPageLength,
                      ),
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    style: body1TextStyle,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: widget.currentPage.toString(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Text(
                '/${widget.totalPages.toString()}',
                style: body1TextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
