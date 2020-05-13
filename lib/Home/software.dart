import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Software extends StatefulWidget {
  @override
  _SoftwareState createState() => _SoftwareState();
}

class _SoftwareState extends State<Software> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _buildListItems("Software Engineering: \nA Practitioner's Approach ",
              'R S Pressman', 'assets/images/RSPressman.jpeg'),
          _buildListItems("Fundamentals of \nSoftware Engineering",
              'Rajib Mall', 'assets/images/rajibmall.jpeg'),
          _buildListItems("", 'Steel rods', 'assets/images/book.png'),
          _buildListItems("", 'Cement Bricks', 'assets/images/book.png'),
          _buildListItems("", 'Gravel', 'assets/images/book.png'),
          _buildListItems("", 'Marble Slabs', 'assets/images/book.png'),
        ],
      ),
    );
  }

  _buildListItems(String bookName, String author, String imgPath) {
    return Padding(
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
                    child: Image.asset(imgPath, height: 50.0, width: 50.0),
                  ),
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bookName,
                      style: GoogleFonts.notoSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      author,
                      style: GoogleFonts.notoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
