import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/Components/Headings/heading.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/helperCard.dart';
import 'package:sastra_ebooks/Profile/SettingScreens/buyacoke.dart';
import 'package:sastra_ebooks/Services/paths.dart';
import 'package:sastra_ebooks/Services/user.dart';

import '../../Services/Responsive/size_config.dart';

class AboutUs extends StatefulWidget {
  static const id = '/about';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Developer> devs = [
    Developer(
        picPath: Images.tonAn,
        name: 'ton-An',
        country: 'Germany',
        level: 'Intermediate'),
    Developer(
        picPath: Images.tonAn,
        name: 'Name',
        country: 'Country',
        level: 'Intermediate'),
    Developer(
        picPath: Images.tonAn,
        name: 'Name',
        country: 'Country',
        level: 'Intermediate'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LargeHeading(
                size: HeadingSize.large,
                text: 'Who\nAre We',
                highlightText: ' ?',
              ),
              SizedBox(height: 20.0),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: devs.map((dev) => DevCard(dev)).toList(),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            color: Colors.black, fontWeight: FontWeight.normal),
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
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
