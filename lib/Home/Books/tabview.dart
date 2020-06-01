import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Books/pdf.dart';


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
          return _buildListItems(widget.data[index]["Name"],widget.data[index]["Images"],
              widget.data[index]["Author"],widget.data[index]['Edition'].toString(), widget.data[index]["Link"], widget.data[index]["Type"]);
        },
        itemCount: (widget.data).length,
      ),
    );
  }

  _buildListItems(String itemName, String imgPath, String author, edition, String url, String type) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            print(url);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewerPage(itemName, url),
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
                          child: Image.network(imgPath, height: 50.0, width: 50.0),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            itemName,
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                author + " , ",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3.0),
                              Text(
                                "Edition - " + edition,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            type,
                            style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent,
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
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
