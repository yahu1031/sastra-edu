import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../Services/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/Responsive/size_config.dart';
import 'package:shimmer/shimmer.dart';

class YourSelf extends StatefulWidget {
  @override
  _YourSelfState createState() => _YourSelfState();
}

class _YourSelfState extends State<YourSelf> {
  File _image;
  bool isProfileUpdated = false;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print("Image path $_image");
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask
          .onComplete; // I don't know why this gives me a suggestion
      setState(() {
        print("Profile Picture uploaded");
      });
    }

    User user = Provider.of<User>(context);
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
        child: Column(
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
                        child: (_image != null)
                            ? Image.file(
                                _image,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                fit: BoxFit.fill,
                              ),
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
                            InkWell(
                              onTap: () {
                                print('profile');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => YourSelf(),
                                  ),
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    ds["name"],
                                    style: GoogleFonts.notoSans(
                                      fontSize: 4 * SizeConfig.textMultiplier,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ds["year"],
                                    style: GoogleFonts.notoSans(
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ds["regNo"].toString(),
                                    style: GoogleFonts.notoSans(
                                        fontSize:
                                            2.2 * SizeConfig.textMultiplier,
                                        color: Colors.black),
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
