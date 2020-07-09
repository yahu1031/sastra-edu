import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sastra_ebooks/Components/profile/pictureProfile.dart';
import 'package:sastra_ebooks/Components/profile/profilePicture.dart';
import 'package:sastra_ebooks/Components/profile/profilePicture.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/profile/profilePicture.dart';
import 'package:sastra_ebooks/Dialogs/areYouSureDialog.dart';
import 'package:path/path.dart';

import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/user.dart';

/* Todo:  - Add image cropper
          - prevent user from leaving app during up and download or continue process in the background
 */

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  Future<void> getImage(BuildContext context) async {
    PickedFile pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 30,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedImage != null) {
      print("Image path ${pickedImage.path}");

      bool dialogResult = await areYouSureDialog(context,
          title: 'Are you sure?',
          description:
              'You won\'t be able to recover your old profile picture');

      if (dialogResult)
        uploadPic(pickedImage);
      else
        File(pickedImage.path).delete();
    }
  }

  Future uploadPic(PickedFile pickedImage) async {
    setState(() => PictureProfile.updateImage('placeholder'));

    String imagePath = 'images/proPics/${basename(pickedImage.path)}';
    StorageReference oldProPicReference;

    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imagePath);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(
      File(pickedImage.path),
    );

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    if (taskSnapshot.error == null) {
      oldProPicReference = await FirebaseStorage.instance
          .getReferenceFromUrl(UserData.proPicUrl);

      UserData.proPicUrl = await taskSnapshot.ref.getDownloadURL();

      Firestore.instance.document("Data/${UserData.uid}").updateData({
        "pro_pic": UserData.proPicUrl,
      });
      print(UserData.proPicUrl);
    }

    print("Profile Picture uploaded");

    setState(() {
      PictureProfile.updateImage(UserData.proPicUrl);
    });

    oldProPicReference.delete();
    File(pickedImage.path).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: kLightHighlightColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        getImage(context);
                      },
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 180,
                        height: 180,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(100),
                          child: PictureProfile(),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kHighlightColor,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: kLightColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  UserData.name,
                  style: GoogleFonts.notoSans(
                    fontSize: 3 * SizeConfig.textMultiplier,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  UserData.year,
                  style: GoogleFonts.notoSans(
                      fontSize: 3 * SizeConfig.textMultiplier,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  UserData.branch,
                  style: GoogleFonts.notoSans(
                      fontSize: 2.2 * SizeConfig.textMultiplier,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  UserData.regNo.toString(),
                  style: GoogleFonts.notoSans(
                      fontSize: 2.2 * SizeConfig.textMultiplier,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
