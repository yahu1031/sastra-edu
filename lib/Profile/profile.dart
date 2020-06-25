import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/listItem.dart';
import 'package:sastra_ebooks/Components/profileInfo.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/screens/mailUs.dart';
import 'package:sastra_ebooks/Services/auth.dart';

import 'Settings/about.dart';
import 'Settings/buyacoke.dart';

class Profile extends StatefulWidget {
  static const String id = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool switchState = false;

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: AppBarTitle('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ProfileInfo(),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              ListItem(
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => Notifications()));
//                      print('Notifications');
//                      Dialogs.notfoundDialog(context);
//                    },
                title: kNotificationsString,
                icon: Icons.notifications_active, onPressed: () {},
              ),
              ListItem(
                onPressed: () => Navigator.pushNamed(context, MailUs.id),
                title: kSupportString,
                icon: Icons.feedback,
              ),
              ListItem(
                onPressed: () => Navigator.pushNamed(context, About.id),
                title: kAboutUsString,
                icon: Icons.person,
              ),
              ListItem(
                onPressed: () => Navigator.pushNamed(context, BuyACoke.id),
                title: kDonationString,
                icon: Icons.card_giftcard,
//                    SvgPicture.asset(
//                      Images.coke,
//                      color: Colors.lightBlueAccent,
//                      height: 20.0,
//                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
