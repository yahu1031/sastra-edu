import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';

class Support extends StatefulWidget {
  static const id = '/support';
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LargeHeading(
                  text: 'Can We Help',
                  highlightText: ' ?',
                  size: HeadingSize.large,
                ),
//                RichText(
//                  text: TextSpan(
//                    children: <TextSpan>[
//                      TextSpan(
//                        text: 'How can we help you',
//                        style: GoogleFonts.montserrat(
//                            fontSize: 8 * SizeConfig.widthMultiplier,
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold),
//                      ),
//                      TextSpan(
//                        text: ' ?',
//                        style: GoogleFonts.montserrat(
//                            fontSize: 10 * SizeConfig.widthMultiplier,
//                            color: Colors.lightBlueAccent,
//                            fontWeight: FontWeight.bold),
//                      ),
//                    ],
//                  ),
//                ),
                SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "Hey there, We hope everything is fine. We would be pleased to assist you in case you need technical support.",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TappableSubtitle(
                      descriptionText: 'Click Here To',
                      actionText: 'Open the Support Form',
                      onActionTap: () {},
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text(
//                          "Click here to ",
//                          style:
//                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
//                        ),
//                        InkWell(
//                          onTap: () {
//                            showDialog(
//                              barrierDismissible: false,
//                              context: context,
//                              child: AlertDialog(
//                                shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(10),
//                                ),
//                                title: Text(
//                                  'How can we help you ?',
//                                  style: TextStyle(color: Colors.blue),
//                                ),
//                                content: Center(
//                                  child: Form(
//                                    child: Column(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.center,
//                                      children: <Widget>[
//                                        TextFormField(
//                                          decoration: InputDecoration(
//                                              fillColor: Colors.grey,
//                                              labelText: "Name"),
//                                        ),
//                                        TextFormField(
//                                          decoration: InputDecoration(
//                                              labelText: "Your issue please"),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                                actions: <Widget>[
//                                  FlatButton(
//                                    onPressed: () => Navigator.of(context)
//                                        .pop(DialogAction.abort),
//                                    child: const Text(
//                                      'Ok',
//                                      style: TextStyle(color: Colors.lightBlue),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            );
//                          },
//                          child: Text(
//                            'open form ',
//                            style: GoogleFonts.poppins(
//                              fontWeight: FontWeight.w600,
//                              color: Colors.lightBlueAccent,
//                            ),
//                          ),
//                        ),
//                        Text(
//                          "📄.",
//                          style:
//                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
//                        ),
//                      ],
//                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
