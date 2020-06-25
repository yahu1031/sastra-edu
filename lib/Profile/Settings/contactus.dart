import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Services/Responsive/size_config.dart';

class Contactus extends StatefulWidget {
  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Contact Us',
                        style: GoogleFonts.montserrat(
                            fontSize: 10 * SizeConfig.widthMultiplier,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' .',
                        style: GoogleFonts.montserrat(
                            fontSize: 10 * SizeConfig.widthMultiplier,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "Hey there, How's the day going? We hope great 😅. You are always welcome to contact us."
                                  "Before that, we would like to know something. Please provide the information on what issue you are contacting us.\n\n\n ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Click here to ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {
                              return Alert(
                                title: "Issue .",
                                context: context,
                                content: Form(
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                            fillColor: Colors.grey,
                                            labelText: "Name"),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Your issue please"),
                                      ),
                                    ],
                                  ),
                                ),
                              ).show();
                            },
                            child: Text(
                              'open form ',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          Text(
                            "📄.",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
