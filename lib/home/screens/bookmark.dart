/*
 * Name: bookmark
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/bookmarkIconTitle.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
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
    print(Bookmarks.map.length);
    print(
      Bookmarks.map.entries.map((entry) {
        Widget w = Text('${entry.key}, ${entry.value[0]}');
        return w;
      }).toList(),
    );

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
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ...Bookmarks.map.entries.map((entry) {
                    Widget w = Column(
                      children: <Widget>[
                        BookListItem(
                          book: Book.bookInstancesMap[entry.key],
                        ),
                        for (int page in entry.value) Text('Page: $page')
                      ],
                    );
//                    Text('${entry.key}, ${entry.value[0]}');
                    return w;
                  }).toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
