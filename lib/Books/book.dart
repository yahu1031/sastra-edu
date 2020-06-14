import 'package:flutter/cupertino.dart';

class Book {
  static final List<Book> bookInstancesList = [];
  final String name, imgUrl, author, url;
  final int id, edition;

  factory Book({
    @required int id,
    @required String name,
    @required String imgUrl,
    @required String author,
    @required String url,
    @required int edition,
  }) {
    for (Book book in bookInstancesList) {
      if (book.id == id) {
        return book;
      }
    }

    final Book newBook = Book._internal(id, name, imgUrl, author, url, edition);
    print(newBook.name);
    bookInstancesList.add(newBook);

    //for (Book book in bookList) print(book.id);
    return bookInstancesList.last;
  }

  Book._internal(
      this.id, this.name, this.imgUrl, this.author, this.url, this.edition);
}
