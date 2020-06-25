import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import './profilePicture.dart';

import '../Services/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/Responsive/size_config.dart';
import 'package:shimmer/shimmer.dart';

class YourSelf extends StatefulWidget {
  final BuildContext context;

  YourSelf(this.context);

  @override
  _YourSelfState createState() => _YourSelfState();
}

class _YourSelfState extends State<YourSelf> {
  File _image;
  bool isProfileUpdated = false;
  String imageUrl;
  User user;

  void initState() {
    user = Provider.of<User>(widget.context);
    getProfileImage();
    super.initState();
  }

  void getProfileImage() async {
    String imageUrlTemp =
    (await Firestore.instance.document('Data/${user.uid}').get())
        .data['pro_pic']
        .toString();
    setState(() {
      imageUrl = imageUrlTemp;
    });

    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print("Image path $_image");
      });
    }

    Future uploadPic(BuildContext context) async {
      String proPicUrl;
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      if (taskSnapshot.error == null) {
        String dwurl = await taskSnapshot.ref.getDownloadURL();
        print(dwurl);
        Firestore.instance
            .document("Data/${user.uid}")
            .updateData({"pro_pic": dwurl});
        proPicUrl =
            (await Firestore.instance.document('Data/${user.uid}').get())
                .data['pro_pic']
                .toString();
      }
      setState(() {
        print("Profile Picture uploaded");
        imageUrl = proPicUrl;
        ProfilePicture(
          imageUrl: imageUrl,
        );
      });
    }

    return Scaffold(
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
              'About You',
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: isProfileUpdated
                ? IconButton(
              onPressed: () {
                try {
                  isProfileUpdated = false;
                  uploadPic(context);
                } catch (e) {
                  isProfileUpdated = true;
                }
              },
              icon: Icon(
                Icons.done,
                size: 35.0,
                color: Colors.lightBlueAccent,
              ),
            )
                : Container(),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          print("Dp");
                          try {
                            isProfileUpdated = true;
                            getImage();
                          } catch (e) {
                            isProfileUpdated = false;
                          }
                        },
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.lightBlueAccent,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 190.0,
                              height: 190.0,
                              child: ProfilePicture(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                textDirection: TextDirection.ltr,
                                children: [
                                  Text(
                                    ds["name"],
                                    style: GoogleFonts.notoSans(
                                      fontSize: 4 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height:20.0),
                                  Text(
                                    ds["year"],
                                    style: GoogleFonts.notoSans(
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height:20.0),
                                  Text(
                                    ds["regNo"].toString(),
                                    style: GoogleFonts.notoSans(
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(height:20.0),
                                  Text(
                                    ds["branch"].toString() + " Engineering",
                                    style: GoogleFonts.notoSans(
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Made with ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w300, color: Colors.black54,)
                    ),
                    TextSpan(
                      text: '💚 .',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
