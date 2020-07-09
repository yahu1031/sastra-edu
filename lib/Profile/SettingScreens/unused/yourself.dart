import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Components/profile/pictureProfile.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Components/profile/profilePicture.dart';
import '../../../Services/Responsive/size_config.dart';
import '../../../Services/user.dart';

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

  Future getImage() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    setState(() {
      _image = image;
      print("Image path $_image.");
    });
    _image.delete();
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
      proPicUrl = (await Firestore.instance.document('Data/${user.uid}').get())
          .data['pro_pic']
          .toString();
    }
    setState(() {
      print("Profile Picture uploaded");
      imageUrl = proPicUrl;
      PictureProfile.updateImage(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(right: kPadding),
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    print("Dp");
                    try {
                      isProfileUpdated = true;
                      await getImage();
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
                        child: PictureProfile(),
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
//                          textDirection: TextDirection.ltr,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    ds["name"],
                                    style: GoogleFonts.notoSans(
                                      fontSize: 4 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    ds["year"],
                                    style: GoogleFonts.notoSans(
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
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
                                  Text(
                                    ds["branch"].toString(),
                                    style: GoogleFonts.notoSans(
                                      fontSize: 2.2 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
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
            ),
          ],
        ),
      ),
    );
  }
}
