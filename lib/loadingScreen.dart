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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokstory_flutter_lottie/lokstory_flutter_lottie.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/components/customLinearProgressIndicator.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/home/homeHandler.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/downloadBook.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/services/lottieAnimations.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'books/book.dart';
import 'books/bookCategory.dart';
import 'misc/bookmarks.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/loadingScreen';
  final User firebaseUser;
  LoadingScreen(this.firebaseUser);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
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
          .collection('user_data')
          .doc(widget.firebaseUser.uid)
          .get();

      setLoadingProgress(.2);

      Map data = document.data();
      final user = UserData(
        widget.firebaseUser.uid,
        widget.firebaseUser.email,
        data['name'],
        data["branch"],
        data['semester'],
        data['regNo'],
      );

      setLoadingProgress(.4);

      DownloadBook.init();

      FavoriteBooks.init(user.uid, List<String>.from(data['favoriteBooks']));

      Bookmarks.init(user.uid, data['bookmarks']);

      setLoadingProgress(.5);

      // Todo: need to change db from firstYear to number
      bookList = (await FirebaseFirestore.instance
              .collection('book_lists')
              .doc('3')
              // .doc('${user.semester}')
              .get())
          .data();

      setLoadingProgress(.7);

      await fetchBooks(bookList['categories']);

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

  Future getBookCategory(Map bookCategory) async {
    List bookReferences = bookCategory['books'];
    List<Book> books = [];

    List<Future Function()> futures = bookReferences.map((bookReference) {
      Future<void> future() async {
        Map book = (await bookReference.get()).data();
        final String bookStoragePath = '/books/${book['isbn']}';
        final coverRef =
            FirebaseStorage.instance.ref().child('$bookStoragePath/cover.jpg');
        final pdfRef =
            FirebaseStorage.instance.ref().child('$bookStoragePath/book.pdf');

        List bookUrls = await Future.wait(
            [coverRef.getDownloadURL(), pdfRef.getDownloadURL()]);

        books.add(
          Book(
            isbn: book['isbn'],
            author: book['author'],
            title: book["title"],
            edition: book['edition'],
            imgUrl: bookUrls[0],
            url: bookUrls[1],
            outline: book['outline'],
          ),
        );
      }

      return future;
    }).toList();

    await Future.wait([
      for (var future in futures) future(),
    ]);

    BookCategory(name: bookCategory['title'], books: books);
  }

  void loadingFinished() {
    isLoadingFinished = true;
  }

  void setLoadingProgress(double progress) {
    setState(() {
      loadingProgressValue = progress;
    });
  }

  Future<void> fetchBooks(List bookList) async {
    List categoryList = [];
    List<Future Function()> bookListFutures = bookList.map((categoryReference) {
      Future<void> future() async =>
          categoryList.add((await categoryReference.get()).data());
      return future;
    }).toList();

    await Future.wait(
      [
        for (var future in bookListFutures) future(),
      ],
    );

    print('-----------------CATEGORIES-----------------------');
    print(categoryList);

    List<Future Function()> categoryFutures = categoryList.map((category) {
      Future containerFuture() async => await getBookCategory(category);
      return containerFuture;
    }).toList();

    await Future.wait(
      [
        for (var future in categoryFutures) future(),
      ],
    );

    //   for (DocumentReference bookReference in categoryList) {
    //     final Map book = (await bookReference.get()).data();
    //     final String bookStoragePath = '/books/${book['isbn']}';
    //     print(bookStoragePath);
    //     final coverRef =
    //         FirebaseStorage.instance.ref().child('$bookStoragePath/cover.jpg');
    //     final pdfRef =
    //         FirebaseStorage.instance.ref().child('$bookStoragePath/book.pdf');
    //     var coverUrl = await coverRef.getDownloadURL();
    //     var pdfUrl = await pdfRef.getDownloadURL();

    //     booksOfCategory.add(
    //       Book(
    //           isbn: book['isbn'],
    //           author: book['author'],
    //           title: book["title"],
    //           edition: book['edition'],
    //           imgUrl: coverUrl,
    //           url: pdfUrl,
    //           outline: book['outline']),
    //     );
    //   }

    //   print(booksOfCategory);

    //   BookCategory(name: category['title'], books: booksOfCategory);

    //   print(BookCategory.bookCategoryInstancesList);
    //   // print(BookCategory.bookCategoryInstancesList[0].books[0].isbn);

    // }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.extraLargePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1,
                child: Lottie.asset(
                  LottieAnimations.welcomeLoading,
                  repeat: true,
                ),
              ),
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
