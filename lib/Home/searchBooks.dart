import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/bookListItem.dart';
import 'package:sastra_ebooks/Components/bookSearchTextField.dart';
import 'package:sastra_ebooks/Components/searchTextField.dart';
import 'package:sastra_ebooks/Home/Books/bookCategory.dart';

import 'Books/book.dart';
import 'Books/pdf.dart';

// Todo: - fix auto focus issue

class SearchBooks extends StatefulWidget {
  static const id = '/searchBooks';

  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  bool autofocusTextField = false;
  int _characterCount = 0;
  List<Book> _searchResults = [];

  @override
  void initState() {
    super.initState();

//    final String searchQuery;
//
//    if (searchQuery.length != 0) getSuggestions(searchQuery);

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
    _characterCount = searchQuery.length;
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                BookSearchTextField(
                  onChanged: (String searchQuery) =>
                      getSuggestions(searchQuery),
                  autofocus: autofocusTextField,
                ),

//                Hero(
//                  tag: 'searchBooks',
//                  child: Material(
//                    child: Container(
//                      padding: EdgeInsets.only(left: 5.0),
//                      decoration: BoxDecoration(
//                        color: Colors.grey.withOpacity(0.1),
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      child: TextField(
//                        autofocus: autofocusTextField,
//                        controller: widget._textEditingController,
//                        textAlign: TextAlign.left,
//                        onChanged: (String searchQuery) =>
//                            getSuggestions(searchQuery),
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.all(15.0),
//                          hintText: 'Search for books',
//                          hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
//                          border: InputBorder.none,
//                          fillColor: Colors.grey.withOpacity(0.5),
//                          prefixIcon: Icon(
//                            Icons.search,
//                            color: Colors.grey,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior(),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20),
                        for (Book book in _searchResults)
                          BookListItem(
                            book: book,
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
