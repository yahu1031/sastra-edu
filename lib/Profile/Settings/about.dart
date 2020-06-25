import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Profile/Settings/buyacoke.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/paths.dart';
import 'package:sastra_ebooks/Services/user.dart';

class About extends StatefulWidget {
  static const id = '/about';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  List<Helpers> helpers = [
    Helpers(
        picPath: Images.tonAn,
        helperName: 'ton-An',
        helperCountry: 'Germany',
        level: 'Intermediate'),
    Helpers(
        picPath: Images.tonAn,
        helperName: 'name 2',
        helperCountry: 'country 2',
        level: 'Intermediate'),
    Helpers(
        picPath: Images.tonAn,
        helperName: 'name 3',
        helperCountry: 'country 3',
        level: 'Intermediate'),
  ];

  Widget helpersTemplate(helpers) {
    return Card(
      child: Container(
        width: 100 * SizeConfig.widthMultiplier,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(3, 3),
              blurRadius: 20,
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(helpers.picPath),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    helpers.helperName,
                    style: GoogleFonts.poppins(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    helpers.helperCountry,
                    style: GoogleFonts.poppins(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "We are students like you, might be one among you 😉. "
                                "We have noticed students are facing issues with sharing their Text books/Notes/References PDFs. "
                                "So, we came up with the idea of M-Books(Mobile Books).Welcome to M-books, a library containing all your required textbooks, notes, references. "
                                "You can handle the books using login system. We do not have user's sign-up 😂 . So main Admin only will access users. "
                                "We are integrated with college student details. So that, student can access books depending their graduating courses . "
                                "I hope you guys will support us . ",
                            style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                              text: 'Get us a coke',
                              style: GoogleFonts.notoSans(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.normal),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BuyACoke()),
                                  );
                                }),
                          TextSpan(
                            text: ' , to support us 😉.',
                            style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: helpers
                          .map((helpers) => helpersTemplate(helpers))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
