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
import 'package:lokstory_flutter_lottie/lokstory_flutter_lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/components/customLinearProgressIndicator.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/home/homeHandler.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/services/lottieAnimations.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'books/book.dart';
import 'books/bookCategory.dart';
import 'misc/bookmarks.dart';
import 'services/images.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/loadingScreen';
  final User firebaseUser;
  LoadingScreen(this.firebaseUser);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
//  String url =
//      "https://drive.google.com/u/0/uc?id=1kP_in6iL-xxOPC9OjNaOzHVtXy4bWkFe&export=download"; //! This is the default url if no condition matches below
  String progressString;
  bool isData = false;
  var dir;
  var data;

  double loadingAnimationValue = 0, loadingProgressValue = 0;

  bool loadingAnimationVisible = false, isLoadingFinished = false;

  String str;
  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    if (widget.firebaseUser != null) {
      loadingAnimationVisible = true;

      Map bookList;
      String appdirectoryPath = (await getApplicationDocumentsDirectory()).path;
      Directory bookDirectory = Directory('$appdirectoryPath/books');

      if (!await bookDirectory.exists()) {
        bookDirectory.create();
      }

      setLoadingProgress(.1);

      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.firebaseUser.uid)
          .get();

      setLoadingProgress(.3);

      Map data = document.data();
      final user = UserData(
        widget.firebaseUser.uid,
        widget.firebaseUser.email,
        data['name'],
        data["branch"],
        data['year'],
        data['regNo'],
      );

      setLoadingProgress(.5);

      FavoriteBooks.init(user.uid, List<String>.from(data['favoriteBooks']));

      setLoadingProgress(.6);

      Bookmarks.init(user.uid, data['bookmarks']);

      setLoadingProgress(.7);

      // Todo: need to change db from firstYear to number
      bookList = (await FirebaseFirestore.instance
              .collection('bookLists')
              .doc('firstYear')
              .get())
          .data();

      setLoadingProgress(.8);

      await fetchBooks(bookList);

      setLoadingProgress(1);

      await Future.doWhile(() async {
        if (isLoadingFinished) {
          return false;
        }
        await Future.delayed(Duration(milliseconds: 200));
        return true;
      });

      Navigator.pushNamedAndRemoveUntil(context, HomeHandler.id, (_) => false,
          arguments: user);
    }
  }

  void loadingFinished() {
    isLoadingFinished = true;
  }

  void setLoadingProgress(double progress) {
    loadingProgressValue = progress;
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
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.extraLargePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Lottie.asset(
              LottieAnimations.welcomeLoading,
              repeat: true,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
              child: CustomLinearProgressIndicator(
                value: loadingProgressValue,
                loadingFinished: loadingFinished,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
