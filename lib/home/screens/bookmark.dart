/*
 * Name: bookmark
 * Use:
 * TODO:    - Add Use of this file
            - if user exits pdf view right after bookmarking the bookmarks screen isn't updated
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/bookmarkIconTitle.dart';
import 'package:sastra_ebooks/components/bookmarkListItem.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class Bookmark extends StatefulWidget {
  static const String id = '/bookmark';
  final appBarTitle = BookmarkIconTitle();

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Heading(
            text: 'Your',
            text2: 'Bookmarks',
            highlightText: ' .',
          ),
          SizedBox(
            height: Dimensions.largePadding,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ...Bookmarks.map.entries.map((entry) {
                    Widget booksBookmarks = Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.padding),
                      child: BookmarkListItem(
                        book: Book.bookInstancesMap[entry.key],
                        bookmarks: entry.value,
                      ),
                    );
                    return booksBookmarks;
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
