// import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'Home/Home.dart';
import 'Services/paths.dart';
import 'package:shimmer/shimmer.dart';

import 'Services/user.dart';
import 'Services/wrapper.dart';

class Splash extends StatefulWidget {
  final User user;
  Splash(this.user);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String url =
      "https://drive.google.com/u/0/uc?id=1ANttpLgFzBaFQZCk1loFZC0NwR5DPo4f&export=download"; //! This is the default url if no condition matches below
  String progressString;
  bool isData = false;
  var dir;
  var data;
  String str;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(milliseconds: 5000), () => goToWrapper());
    if (widget.user != null) {
      str = "";
      for (int i = 0; i < (widget.user.email).length; i++) {
        String char = widget.user.email.substring(i, (i + 1));
        print(char);
        if (char != '@') {
          str = str + char;
        } else {
          print("String:$str");
          print(str.substring(0, 3));
          if (str.substring(0, 3) == "121") {
            url =
                "https://drive.google.com/u/0/uc?id=1ANttpLgFzBaFQZCk1loFZC0NwR5DPo4f&export=download";
          } else if (str.substring(0, 3) == "122") {
            url = ""; //! json url for Second Year books
          } else if (str.substring(0, 3) == "123") {
            url = ""; //! json url for Third Year books
          }
          getJsonData().then((value) {
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
    print(data);
    if (progressString == "Refreshing") {
      isData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.splashPic,
                  height: 250,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.blue[500],
                  highlightColor: Colors.lightBlueAccent,
                  child: new Text(
                    'M-Book Edu',
                    style: GoogleFonts.pacifico(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      MaterialPageRoute(builder: (context) => Home(data)),
    );
  }
}
