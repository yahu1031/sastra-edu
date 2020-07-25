/*
 * Name: loadingScreen
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
            - prevent app from loading if no internet connection and if not everything (except the pdfs) is loaded
 */

import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/home/homeHandler.dart';
import 'package:sastra_ebooks/misc/favoriteBooks.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/components/profile/profilePicture.dart';
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
  String url =
      "https://drive.google.com/u/0/uc?id=1kP_in6iL-xxOPC9OjNaOzHVtXy4bWkFe&export=download"; //! This is the default url if no condition matches below
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
      str = "";
      for (int i = 0; i < (widget.firebaseUser.email).length; i++) {
        String char = widget.firebaseUser.email.substring(i, (i + 1));
        //        print(char);
        if (char != '@') {
          str = str + char;
        } else {
          if (str.substring(0, 3) == "120") {
            url =
                "https://drive.google.com/u/0/uc?id=17X0oNQR9RFl4DJgwVE7Fjg-d4Fxr14QQ&export=download"; //! json url for Fourth Year books
          } else if (str.substring(0, 3) == "121") {
            debugPrint("Third year books");
            url =
                "https://1drv.ws/u/s!Ag5A1hcdHrA-jtUlGstoRsFgBPDNxQ?e=93mR3O"; //! json url for Third Year books
            //"https://drive.google.com/u/0/uc?id=1IX8m8zKhu64fSlaSdbso3JJWolxGhMxV&export=download"; //! json url for Third Year books

          } else if (str.substring(0, 3) == "122") {
            debugPrint("Second year books");
            url =
                "https://drive.google.com/u/0/uc?id=1fuT9cbbRnLLoWsBfE5ifcDpnYjrfCvI2&export=download"; //! json url for Second Year books
          } else if (str.substring(0, 3) == "123") {
            debugPrint("First year books");
            url =
                "https://drive.google.com/u/0/uc?id=1kP_in6iL-xxOPC9OjNaOzHVtXy4bWkFe&export=download"; //! json url for first year
          }

          await getBooksJson();

          fetchBooksFromJson();

          DocumentSnapshot document = await Firestore.instance
              .collection('Data')
              .document(widget.firebaseUser.uid)
              .get();

          final user = User(
            widget.firebaseUser.uid,
            widget.firebaseUser.email,
            document.data['pro_pic'],
            document.data['name'],
            document.data["branch"],
            document.data['year'],
            document.data['regNo'],
          );

          FavoriteBooks.init(
              user.uid, List<String>.from(document.data['favoriteBooks']));

          print(document.data['bookmarks']);
          Bookmarks.init(
              user.uid, Map<String, List>.from(document.data['bookmarks']));
          ProfilePicture.updateImage(user.proPicUrl);

          print("Going to Wrapper");

          Navigator.pushNamedAndRemoveUntil(
              context, HomeHandler.id, (_) => false,
              arguments: user);
        }
      }
    }
  }

  Future<void> getBooksJson() async {
    Dio dio = Dio();
    dir = await getApplicationDocumentsDirectory();
    try {
      await dio.download(
        url,
        "${dir.path}/books.json",
        onReceiveProgress: (rec, total) {
          print("Rec: $rec , Total: $total");
          setState(() {
            isData = false;
            progressString = ((rec / total) * 100).toStringAsFixed(0) +
                "%"; //.toStringAsFixed() 0 indicates upto 0 decimal values, we can use 1 for 1 decimal face
          });
        },
      );
    } catch (e) {
      // Todo: ! Here write a dialog that your internet connection ain't working
      print('OHOH!');
    }

    File file = File("${dir.path}/books.json");

    setState(() {
      data = (json.decode(file.readAsStringSync()));
      progressString = "Refreshing";
      isData = false;
      // debugPrint(data[0]["doctors"].length.toString());
    });
//    print(data);
    if (progressString == "Refreshing") {
      isData = true;
    }
  }

  Future<void> fetchBooksFromJson() async {
    final Map bookCategories = data["Categories"];

    bookCategories.forEach(
      (key, value) {
        final String categoryName = key;
        final List booksJson = value;
        final List<Book> booksOfCategory = [];

        for (Map book in booksJson) {
          booksOfCategory.add(
            Book(
              id: book['id'].toString(),
              author: book['Author'],
              name: book["Name"],
              edition: book['Edition'],
              imgUrl: book["Images"],
              url: book["Link"],
            ),
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
