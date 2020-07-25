/*
 * Name: favorite
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/favoriteIconTitle.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';

class Favorite extends StatefulWidget {
  static const String id = '/favorite';
  final appBarTitle = FavoriteIconTitle();

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    print(FavoriteBooks.list.length);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Heading(
            text: 'Your',
            text2: 'Favorites',
            highlightText: ' .',
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (String id in FavoriteBooks.list)
                    BookListItem(book: Book.bookInstancesMap[id]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
