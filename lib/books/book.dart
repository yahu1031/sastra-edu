/*
 Name: book
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';

class Book {
  static final Map<String, Book> _bookInstancesMap = {};
  final String title, isbn, imgUrl, author, url;
  final int edition;
  final List outline;

  factory Book({
    @required String isbn,
    @required String title,
    @required String imgUrl,
    @required String author,
    @required String url,
    @required int edition,
    @required List outline,
  }) {
    if (_bookInstancesMap.containsKey(isbn)) {
      return _bookInstancesMap[isbn];
    }

    final Book newBook =
        Book._internal(isbn, title, imgUrl, author, url, edition, outline);
    _bookInstancesMap[isbn] = newBook;
    return _bookInstancesMap[isbn];
  }

  Book._internal(this.isbn, this.title, this.imgUrl, this.author, this.url,
      this.edition, this.outline);

  static get bookInstancesMap => _bookInstancesMap;

  static get(isbn) {
    if (_bookInstancesMap.containsKey(isbn)) {
      return bookInstancesMap(isbn);
    } else {
      // Todo: Handle - book being in e.g. favorites but it doesn't exist or isn't part of his library anymore
      throw UnimplementedError();
    }
  }
}
