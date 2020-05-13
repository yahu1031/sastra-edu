// ignore: implementation_imports
import 'package:flutter/src/widgets/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Services/user.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(new Profile());

class Profile extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<Profile> {
  bool switchState = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Shimmer.fromColors(
          baseColor: Colors.blue[500],
          highlightColor: Colors.lightBlueAccent,
          child: Container(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.lightBlueAccent,
            ),
          ),
        ],
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
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Data')
            .document(user.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text("loading Data.. Please wait");
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            padding: const EdgeInsets.only(top: 50.0),
            itemBuilder: (context, index) {
              var ds = snapshot.data;
              return new Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: <Widget>[
                                Text(
                                  ds["name"],
                                  style: GoogleFonts.notoSans(
                                    fontSize: 25.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ds["year"],
                                  style: GoogleFonts.notoSans(
                                      fontSize: 20.0,
                                      color: Colors.lightBlueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ds["regNo"].toString(),
                                  style: GoogleFonts.notoSans(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: new CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
