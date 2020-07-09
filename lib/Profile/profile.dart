import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/listItem.dart';
import 'SettingScreens/about.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/profile/profileInfo.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Misc/screens/mailUs.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'SettingScreens/buyacoke.dart';

class Profile extends StatelessWidget {
  static const String id = '/profile';

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

                // color: Colors.red,
                child: ProfileInfo(),
              ),
            ),
          ),
          Column(
            children: <Widget>[
//              ListItem(
////                    onPressed: () {
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(
////                              builder: (context) => Notifications()));
////                      print('Notifications');
////                      Dialogs.notfoundDialog(context);
////                    },
//                title: kNotificationsString,
//                icon: Icons.notifications_active,
//              ),
              ListItem(
                onPressed: () => Navigator.pushNamed(context, MailUs.id),
                title: kSupportString,
                icon: Icons.feedback,
              ),
              ListItem(
                onPressed: () => Navigator.pushNamed(context, AboutUs.id),
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
