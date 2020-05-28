import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Books/pdf.dart';

import '../../Services/paths.dart';

class All extends StatefulWidget {
  final data;
  All(this.data);

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, index) {
          return _buildListItems(widget.data[index]["Name"], Images.book);
        },
        itemCount: (widget.data).length,
      ),
    );
  }

  _buildListItems(String itemName, String imgPath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(),
          ),
        );
      },
      child: Padding(
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
                        itemName,
                        style: GoogleFonts.notoSans(
                          fontSize: 14.0,
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
      ),
    );
  }
}
