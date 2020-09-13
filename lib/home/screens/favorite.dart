/*
 Name: favorite
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/favoriteIconTitle.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/listScreen.dart';
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

    return ListScreen(
      heading: Heading(
        text: 'Your',
        text2: 'Favorites',
        highlightText: ' .',
      ),
      placeholderString: 'your favorite books',
      isEmpty: FavoriteBooks.list.isEmpty,
      listItems: [
        for (String isbn in FavoriteBooks.list)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.padding),
            child: BookListItem(
              book: Book.bookInstancesMap[isbn],
              setStateParent: setState,
              isFavoriteScreen: true,
            ),
          ),
      ],
    );
  }
}
