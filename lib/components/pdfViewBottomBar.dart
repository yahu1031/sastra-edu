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
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';

import 'buttons/iconButtons/iconToggleButton.dart';

class PdfViewBottomBar extends StatelessWidget {
  final int totalPages, totalPageLength, currentPage;

  final String bookId;

  final bool pageBookmarked, isFavorite;

  final VoidCallback onBookmarkPressed, onFavoritePressed, onOutlinePressed;

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
    @required this.onOutlinePressed,
    @required this.onPageNumberSubmit,
    this.textEditingController,
  }) : totalPageLength = totalPages.toString().length;

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
            onPressed: onFavoritePressed,
            isActive: isFavorite,
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
            onPressed: onBookmarkPressed,
            isActive: pageBookmarked,
            activeIcon: Icons.bookmark,
            disabledIcon: Icons.bookmark_border,
//            onActivate: () {
//              Bookmarks.add(widget.bookId, widget.currentPage);
//            },
//            onPressed: () {
//              Bookmarks.remove(widget.bookId, widget.currentPage);
//            },
          ),
          IconButton(
            icon: Icon(
              OMIcons.assignment,
            ),
            onPressed: onOutlinePressed,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 10 * totalPageLength.toDouble(),
                child: Theme(
                  data: ThemeData(
                    primaryColor: CustomColors.darkColor,
                  ),
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: onPageNumberSubmit,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                        totalPageLength,
                      ),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    style: body1TextStyle,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: currentPage.toString(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Text(
                '/${totalPages.toString()}',
                style: body1TextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
