/*
 * Name: book
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';

class Book {
  static final Map<String, Book> _bookInstancesMap = {};
  final String name, id, imgUrl, author, url;
  final int edition;
  final List outline;

  factory Book({
    @required String id,
    @required String name,
    @required String imgUrl,
    @required String author,
    @required String url,
    @required int edition,
    @required List outline,
  }) {
    if (_bookInstancesMap.containsKey(id)) {
      return _bookInstancesMap[id];
    }

    final Book newBook =
        Book._internal(id, name, imgUrl, author, url, edition, outline);
    _bookInstancesMap[id] = newBook;
    return _bookInstancesMap[id];
  }

  Book._internal(this.id, this.name, this.imgUrl, this.author, this.url,
      this.edition, this.outline);

  static get bookInstancesMap => _bookInstancesMap;
}
