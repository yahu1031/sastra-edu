/*
 * Name: book
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';

class Book {
  static final Map<String, Book> _bookInstancesMap = {};
  final String name, id, imgUrl, author, url;
  final edition;

  factory Book({
    @required String id,
    @required String name,
    @required String imgUrl,
    @required String author,
    @required String url,
    @required int edition,
  }) {
    if (_bookInstancesMap.containsKey(id)) {
      return _bookInstancesMap[id];
    }

    final Book newBook = Book._internal(id, name, imgUrl, author, url, edition);
    _bookInstancesMap[id] = newBook;
    return _bookInstancesMap[id];
  }

  Book._internal(
      this.id, this.name, this.imgUrl, this.author, this.url, this.edition);

  static get bookInstancesMap => _bookInstancesMap;
}
