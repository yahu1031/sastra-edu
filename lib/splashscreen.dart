// import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sastra_ebooks/Services/wrapper.dart';
import 'package:shimmer/shimmer.dart';

import 'Services/wrapper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String url =
      "https://drive.google.com/u/0/uc?id=1ANttpLgFzBaFQZCk1loFZC0NwR5DPo4f&export=download";
  String progressString;
  bool isData = false;
  var dir;
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(milliseconds: 5000), () => goToWrapper());
    getJsonData().then((value) {
      print("Going to Wrapper");
      goToWrapper();
    });
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
    } catch (e) {}
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
                Image.asset('assets/images/splash.png'),
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
      MaterialPageRoute(builder: (context) => Wrapper(data)),
    );
  }
}
