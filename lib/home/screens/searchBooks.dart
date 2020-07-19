/*
 * Name: searchBooks
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/bookCategory.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/textFields/bookSearchTextField.dart';

class SearchBooks extends StatefulWidget {
  static const id = '/searchBooks';

  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  bool autofocusTextField = false;
  List<Book> _searchResults = [];

  @override
  void initState() {
    super.initState();

    final String searchQuery = BookSearchTextField.textEditingController.text;

    if (searchQuery.length != 0) getSuggestions(searchQuery);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        autofocusTextField = true;
      });
    });
  }

  void getSuggestions(String searchQuery) async {
    searchQuery = searchQuery.toLowerCase();
    print(searchQuery);

    /// runs complete search again if is not empty
    if (searchQuery.isNotEmpty) {
      _searchResults = [];
      for (BookCategory bookCategory
          in BookCategory.bookCategoryInstancesList) {
        for (Book book in bookCategory.books) {
          final String bookName = book.name.toLowerCase();
          if (bookName.contains(searchQuery)) {
            if (bookName.startsWith(searchQuery)) {
              _searchResults.insert(0, book);
            } else {
              _searchResults.add(book);
            }
          }
        }
      }

      /// runs if searchQuery is empty and clears all searchResults
    } else if (searchQuery.isEmpty && _searchResults.isNotEmpty) {
      _searchResults = [];
    }

    print(_searchResults);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            top: 20,
            right: 15,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
//              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 30),
                        for (Book book in _searchResults)
                          BookListItem(
                            book: book,
                          ),
                      ],
                    ),
                  ),
                ),
                BookSearchTextField(
                  onChanged: (String searchQuery) =>
                      getSuggestions(searchQuery),
                  autofocus: autofocusTextField,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
