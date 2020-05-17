// ignore: implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/user.dart';
import '../Services/wrapper.dart';

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
                                                fontSize: 4 *
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
                                        child: new CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage: AssetImage(
                                              'assets/images/profile.jpg'),
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
                            print('Notifictaions');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications_active,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Notifictaions",
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
                            print('Support');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
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
                            print('Contact Us');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
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
                            print('Books Preference');
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
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
                              print("Buy us coffee");
                            });
                          },
                          child: Container(
                            height: 50.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_cafe,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    "Buy us a coffee",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.notoSans(fontSize: 17.0),
                                  ),
                                  // CupertinoSwitch(
                                  //   activeColor: Colors.lightBlueAccent,
                                  //   value: switchState,
                                  //   onChanged: (bool value) {
                                  //     setState(() {
                                  //       switchState = value;
                                  //     });
                                  //     print(value);
                                  //   },
                                  // ),
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
                              padding: EdgeInsets.all(15.0),
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
