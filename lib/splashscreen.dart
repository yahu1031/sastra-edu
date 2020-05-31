// import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'file:///C:/Users/ton-A/AndroidStudioProjects/sastra-edu/lib/Profile/profilePicture.dart';

import 'Home/Home.dart';
import 'Services/paths.dart';
import 'Services/user.dart';

class Splash extends StatefulWidget {
  final User user;
  Splash(this.user);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
    // Timer(Duration(milliseconds: 5000), () => goToWrapper());
    if (widget.user != null) {
      str = "";
      for (int i = 0; i < (widget.user.email).length; i++) {
        String char = widget.user.email.substring(i, (i + 1));
//        print(char);
        if (char != '@') {
          str = str + char;
        } else {
//          print("String:$str");
//          print(str.substring(0, 3));
          if (str.substring(0, 3) == "120") {
            url =
                "https://drive.google.com/u/0/uc?id=17X0oNQR9RFl4DJgwVE7Fjg-d4Fxr14QQ&export=download"; //! json url for Fourth Year books
          } else if (str.substring(0, 3) == "121") {
            debugPrint("Third year books");
            url =
                "https://drive.google.com/u/0/uc?id=1IX8m8zKhu64fSlaSdbso3JJWolxGhMxV&export=download"; //! json url for Third Year books

          } else if (str.substring(0, 3) == "122") {
            debugPrint("Second year books");
            url =
                "https://drive.google.com/u/0/uc?id=1fuT9cbbRnLLoWsBfE5ifcDpnYjrfCvI2&export=download"; //! json url for Second Year books
          } else if (str.substring(0, 3) == "123") {
            debugPrint("First year books");
            url =
                "https://drive.google.com/u/0/uc?id=1kP_in6iL-xxOPC9OjNaOzHVtXy4bWkFe&export=download"; //! json url for first year
          }

          getJsonData().then((value) async {
            var document = await Firestore.instance
                .collection('Data')
                .document(widget.user.uid)
                .get();

            ProfilePicture(imageUrl: document.data['pro_pic']);

            print("Going to Wrapper");
            goToWrapper();
          });
          break;
        }
      }
    }
  }

  Future getJsonData() async {
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
      //! Here write a dialog that your internet connection ain't working
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

  goToWrapper() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home(data, context)),
    );
  }
}
