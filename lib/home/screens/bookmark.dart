/*
 * Name: bookmark
 * Use:
 * TODO:    - Add Use of this file
            - if user exits pdf view right after bookmarking the bookmarks screen isn't updated
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/bookmarkIconTitle.dart';
import 'package:sastra_ebooks/components/bookmarkListItem.dart';
import 'package:sastra_ebooks/components/emptyListPlaceholder.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/listScreen.dart';
import 'package:sastra_ebooks/misc/bookmarks.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/textStyles.dart';
import 'package:sastra_ebooks/services/images.dart';

class Bookmark extends StatefulWidget {
  static const String id = '/bookmark';
  final appBarTitle = BookmarkIconTitle();

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return ListScreen(
        heading: Heading(
          text: 'Your',
          text2: 'Bookmarks',
          highlightText: ' .',
        ),
        placeholderString: 'bookmarks',
        isEmpty: Bookmarks.map.isEmpty,
        listItems: [
          for (var bookmarkedBook in Bookmarks.map.entries)
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.padding),
              child: BookmarkListItem(
                book: Book.bookInstancesMap[bookmarkedBook.key],
                bookmarks: bookmarkedBook.value,
              ),
            ),
        ]);
  }
}
