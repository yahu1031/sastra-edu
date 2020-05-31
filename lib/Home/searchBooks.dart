import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Books/pdf.dart';

// Todo: fix auto focus issue

class SearchBooks extends StatefulWidget {
  final Map data;
  final TextEditingController textEditingController;

  SearchBooks(this.data, this.textEditingController);

  @override
  _SearchBooksState createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  int characterCount = 0;
  List searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  void getSuggestions(String searchQuery) async {
//    print('--------------------------');
//    print('previousCharacterCount: $characterCount');
//    print('searchQuery: $searchQuery');
    searchQuery = searchQuery.toLowerCase();

    /// runs complete search again if is not empty
    if (searchQuery.isNotEmpty) {
      searchResults = [];
      for (int i = 0; i < widget.data["Tabs"].length; i++) {
        for (Map book in widget.data[widget.data["Tabs"][i]]) {
          if (book["Name"].toLowerCase().contains(searchQuery)) {
            searchResults.add(book);
          }
        }
      }

      /// runs if searchQuery is empty and clears all searchResults
    } else if (searchQuery.isEmpty && searchResults.isNotEmpty) {
      searchResults = [];
    }

    characterCount = searchQuery.length;
    setState(() {});
//    print('searchResults: $searchResults');
//    print('characterCount: $characterCount');
  }

  _buildListItems(
      String itemName, String imgPath, String author, edition, String url) {
    return InkWell(
      onTap: () {
        print(url);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(itemName, url),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Container(
                    height: 75.0,
                    width: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Image.network(imgPath, height: 50.0, width: 50.0),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemName,
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            author + " , ",
                            style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 3.0),
                          Text(
                            "Edition - " + edition.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 20),
              Hero(
                tag: 'searchBooks',
                child: Material(
                  child: Container(
                    padding: EdgeInsets.only(left: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: widget.textEditingController,
                      textAlign: TextAlign.left,
                      onChanged: (String searchQuery) =>
                          getSuggestions(searchQuery),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        hintText: 'Search for books',
                        hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
                        border: InputBorder.none,
                        fillColor: Colors.grey.withOpacity(0.5),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height,
                child: ListView(
                  children: <Widget>[
                    for (Map book in searchResults)
                      _buildListItems(book["Name"], book["Images"],
                          book['Author'], book['Edition'], book["Link"])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
