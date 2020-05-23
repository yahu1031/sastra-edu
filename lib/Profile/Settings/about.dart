import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/paths.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_india_app.dart';
import 'package:upi_india/upi_india_response.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Shimmer.fromColors(
          baseColor: Colors.blue[500],
          highlightColor: Colors.lightBlueAccent,
          child: Container(
            child: new Text(
              'About Us',
              style: GoogleFonts.pacifico(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body:Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(""),
              Text("hi"),
            ],
          ),
        ),
      ),
    );
  }
}