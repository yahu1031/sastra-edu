<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Profile/profilePicture.dart';
import '../Profile/Settings/buyacoke.dart';
import '../Profile/Settings/contactus.dart';
import '../Profile/yourself.dart';
import '../Services/Responsive/size_config.dart';
import '../Services/auth.dart';
import '../Services/dialogs.dart';
import '../Services/paths.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/user.dart';
import '../Services/wrapper.dart';
import 'Settings/about.dart';
import 'Settings/support.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool switchState = false;

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Shimmer.fromColors(
          baseColor: Colors.blue[500],
          highlightColor: Colors.lightBlueAccent,
          child: Container(
            child: new Text(
              'Profile',
              style: GoogleFonts.pacifico(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0),
              child: StreamBuilder(
                stream: user != null
                    ? Firestore.instance
                        .collection('Data')
                        .document(user.uid)
                        .snapshots()
                    : null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    padding: const EdgeInsets.only(top: 50.0),
                    itemBuilder: (context, index) {
                      var ds = snapshot.data;
                      return new Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1 * SizeConfig.widthMultiplier),
                        child: Center(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print('profile');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => YourSelf(context),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          textDirection: TextDirection.ltr,
                                          children: <Widget>[
                                            Text(
                                              ds["name"],
                                              style: GoogleFonts.notoSans(
                                                fontSize: 3 *
                                                    SizeConfig.textMultiplier,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ds["year"],
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 3 *
                                                      SizeConfig.textMultiplier,
                                                  color: Colors.lightBlueAccent,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ds["regNo"].toString(),
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 2.2 *
                                                      SizeConfig.textMultiplier,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: ProfilePicture(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              child: Wrap(
                spacing: 2 * SizeConfig.imageSizeMultiplier,
                runSpacing: 2.5 * SizeConfig.imageSizeMultiplier,
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Notifications()));
                            // print('Notifications');
                            Dialogs.notfoundDialog(context);
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications_active,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Notifications",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Support()));
                            print('Support');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.feedback,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Support",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Contactus()));
                            print('Contact Us');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    "Contact Us",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => About()));
                            print('About Us');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 15.0),
                                  Text(
                                    "About Us",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Buyacoke()));
                              print("Buy us coke");
                            });
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(Images.coke,
                                      color: Colors.lightBlueAccent,
                                      height: 20.0),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Buy us a coke",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            await _auth.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()));
                            print('Logged out');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.power_settings_new,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "LOGOUT",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
=======
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
>>>>>>> master
