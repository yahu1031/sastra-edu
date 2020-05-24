import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Profile/Settings/buyacoke.dart';
import '../../Services/Responsive/size_config.dart';

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
                        text: 'Who are we',
                        style: GoogleFonts.montserrat(
                            fontSize: 10 * SizeConfig.widthMultiplier,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' ?',
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
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "We are students like you, might be one among you 😉. "
                              "We have noticed students are facing issues with sharing their Text books/Notes/References PDFs. "
                              "So, we came up with the idea of M-Books(Mobile Books).Welcome to M-books, a library containing all your required textbooks, notes, references. "
                              "You can handle the books using login system. We do not have user's sign-up 😂 . So main Admin only will access users. "
                              "We are integrated with college student details. So that, student can access books depending their graduating courses . "
                              "I hope you guys will support us . ",
                          style: GoogleFonts.notoSans(color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: 'Get us a coke',
                          style: GoogleFonts.notoSans(color: Colors.lightBlueAccent,fontWeight: FontWeight.normal),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Buyacoke()),
                              );
                            }
                        ),
                        TextSpan(
                          text: ' , to support us 😉.',
                          style: GoogleFonts.notoSans(color: Colors.black,fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
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
