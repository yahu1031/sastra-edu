/*
 * Name: bookCategory
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';

import 'book.dart';

class BookCategory {
  static final List<BookCategory> bookCategoryInstancesList = [];
  final String name;
  final List<Book> books;

  factory BookCategory({
    @required String name,
    @required List<Book> books,
  }) {
    for (BookCategory bookCategory in bookCategoryInstancesList) {
      if (bookCategory.name == name) {
        return bookCategory;
      }
    }

    final BookCategory newBookCategory = BookCategory._internal(
      name: name,
      books: books,
    );

    bookCategoryInstancesList.add(newBookCategory);
    return bookCategoryInstancesList.last;
  }

  BookCategory._internal({@required this.name, @required this.books});
}
