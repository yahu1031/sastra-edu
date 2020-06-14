import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/appTitle.dart';
import 'package:sastra_ebooks/Components/CustomScaffold.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/listItem.dart';
import 'package:sastra_ebooks/Components/profileInfo.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Misc/screens/mailUs.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/user.dart';

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
        title: AppTitle('Profile'),
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
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: 7.0),
//              child: StreamBuilder(
//                stream: user != null
//                    ? Firestore.instance
//                        .collection('Data')
//                        .document(user.uid)
//                        .snapshots()
//                    : null,
//                builder: (BuildContext context, AsyncSnapshot snapshot) {
//                  if (!snapshot.hasData) {
//                    return CircularProgressIndicator();
//                  }
//                  return ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: 1,
//                    padding: const EdgeInsets.only(top: 50.0),
//                    itemBuilder: (context, index) {
//                      var ds = snapshot.data;
//                      return Padding(
//                        padding: EdgeInsets.symmetric(horizontal: 10),
//                        child: Center(
//                          child: Column(
//                            children: [
//                              InkWell(
//                                onTap: () {
//                                  print('profile');
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => YourSelf(context),
//                                    ),
//                                  );
//                                },
//                                child: Container(
//                                  child: Row(
//                                    crossAxisAlignment:
//                                        CrossAxisAlignment.center,
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceBetween,
//                                    children: [
//                                      Container(
//                                        child: Column(
//                                          crossAxisAlignment:
//                                              CrossAxisAlignment.start,
//                                          textDirection: TextDirection.ltr,
//                                          children: <Widget>[
//                                            Text(
//                                              ds["name"],
//                                              style: GoogleFonts.notoSans(
//                                                fontSize: 3 *
//                                                    SizeConfig.textMultiplier,
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.bold,
//                                              ),
//                                            ),
//                                            Text(
//                                              ds["year"],
//                                              style: GoogleFonts.notoSans(
//                                                  fontSize: 3 *
//                                                      SizeConfig.textMultiplier,
//                                                  color: Colors.lightBlueAccent,
//                                                  fontWeight: FontWeight.bold),
//                                            ),
//                                            Text(
//                                              ds["regNo"].toString(),
//                                              style: GoogleFonts.notoSans(
//                                                  fontSize: 2.2 *
//                                                      SizeConfig.textMultiplier,
//                                                  color: Colors.black),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      Container(
//                                        width: 100,
//                                        height: 100,
//                                        child: ClipRRect(
//                                          clipBehavior: Clip.hardEdge,
//                                          borderRadius:
//                                              BorderRadius.circular(50),
//                                          child: ProfilePicture(),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      );
//                    },
//                  );
//                },
//              ),
//            ),
//            SizedBox(height: 40.0),
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
                icon: Icons.notifications_active,
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
