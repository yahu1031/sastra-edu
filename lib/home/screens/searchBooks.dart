/*
 Name: searchBooks
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/books/book.dart';
import 'package:sastra_ebooks/books/bookCategory.dart';
import 'package:sastra_ebooks/components/bookListItem.dart';
import 'package:sastra_ebooks/components/buttons/textFieldButton/textFieldButton.dart';
import 'package:sastra_ebooks/components/textFields/bookSearchTextField.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class SearchBooks extends StatefulWidget {
  static const id = '/searchBooks';

  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  List<Book> _searchResults = [];
  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;

  @override
  void initState() {
    super.initState();
    final String searchQuery = BookSearchTextField.textEditingController.text;

    if (searchQuery.length != 0) getSuggestions(searchQuery);
    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
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
          final String bookName = book.title.toLowerCase();
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
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          print(_keyboardState);
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              top: 20,
              right: 15,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          SizedBox(height: 30),
                          for (Book book in _searchResults)
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: Dimensions.padding),
                              child: BookListItem(
                                book: book,
                                setStateParent: setState,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  BookSearchTextField(
                    onChanged: (String searchQuery) =>
                        getSuggestions(searchQuery),
                    suffixIcon: TextFieldButton(
                      onPressed: () => Navigator.pop(context),
                      highlightColor: Colors.blueAccent.withOpacity(.15),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
