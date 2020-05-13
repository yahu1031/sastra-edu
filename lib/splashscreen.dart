import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:sastra_ebooks/Services/wrapper.dart';
import 'package:shimmer/shimmer.dart';

import 'Services/wrapper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 5000), () => goToWrapper());
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
      MaterialPageRoute(builder: (context) => Wrapper()),
    );
  }
}
