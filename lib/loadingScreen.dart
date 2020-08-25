/*
 * Name: loadingScreen
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
            - prevent app from loading if no internet connection and if not everything (except the pdfs) is loaded
 */

import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/home/homeHandler.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'books/book.dart';
import 'books/bookCategory.dart';
import 'misc/bookmarks.dart';
import 'services/images.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/loadingScreen';
  final FirebaseUser firebaseUser;
  LoadingScreen(this.firebaseUser);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
//  String url =
//      "https://drive.google.com/u/0/uc?id=1kP_in6iL-xxOPC9OjNaOzHVtXy4bWkFe&export=download"; //! This is the default url if no condition matches below
  String progressString;
  bool isData = false;
  var dir;
  var data;
  String str;
  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    if (widget.firebaseUser != null) {
      Map bookList;
      String appdirectoryPath = (await getApplicationDocumentsDirectory()).path;
      Directory bookDirectory = Directory('$appdirectoryPath/books');

      if (!await bookDirectory.exists()) {
        bookDirectory.create();
      }
      DocumentSnapshot document = await Firestore.instance
          .collection('userData')
          .document(widget.firebaseUser.uid)
          .get();
      print(document.data['year']);
      final user = User(
        widget.firebaseUser.uid,
        widget.firebaseUser.email,
        document.data['name'],
        document.data["branch"],
        document.data['year'],
        document.data['regNo'],
      );

      FavoriteBooks.init(
          user.uid, List<String>.from(document.data['favoriteBooks']));

      Bookmarks.init(user.uid, document.data['bookmarks']);

      // Todo: need to change db from firstYear to
      bookList = await Firestore.instance
          .collection('bookLists')
          .document('firstYear')
          .get()
          .then((documentSnapshot) => documentSnapshot.data);

      await fetchBooks(bookList);

      Navigator.pushNamedAndRemoveUntil(context, HomeHandler.id, (_) => false,
          arguments: user);
    }
  }

  Future<void> fetchBooks(Map bookList) async {
    final Map bookCategories = bookList["Categories"];

    bookCategories.forEach(
      (key, value) {
        final String categoryName = key;
        final List bookCategory = value;
        final List<Book> booksOfCategory = [];

        for (Map book in bookCategory) {
          booksOfCategory.add(
            Book(
                id: book['id'].toString(),
                author: book['Author'],
                name: book["Name"],
                edition: book['Edition'],
                imgUrl: book['Images'],
                url: book['Link'],
                outline: book['outline']),
          );
        }

        BookCategory(name: categoryName, books: booksOfCategory);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Images.splashPic,
                  height: 250,
                ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier,
                ),
                TyperAnimatedTextKit(
                  text: [
                    "We are fetching books for you...",
                  ],
                  textStyle: GoogleFonts.poppins(color: Colors.lightBlueAccent),
                  textAlign: TextAlign.start,
                  speed: Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
