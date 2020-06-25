import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/profilePicture.dart';
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/user.dart';

// Todo: - Add upload profile pic functionality

class ProfileInfo extends StatelessWidget {
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//      print("Image path $_image");
//    });
//  }
//
//  Future uploadPic(BuildContext context) async {
//    String proPicUrl;
//    String fileName = basename(_image.path);
//    StorageReference firebaseStorageRef =
//    FirebaseStorage.instance.ref().child(fileName);
//    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//
//    if (taskSnapshot.error == null) {
//      String dwurl = await taskSnapshot.ref.getDownloadURL();
//      print(dwurl);
//      Firestore.instance
//          .document("Data/${UserData.uid}")
//          .updateData({"pro_pic": dwurl});
//      proPicUrl =
//          (await Firestore.instance.document('Data/${UserData.uid}').get())
//              .data['pro_pic']
//              .toString();
//    }
//    setState(() {
//      print("Profile Picture uploaded");
//      imageUrl = proPicUrl;
//      ProfilePicture(
//        imageUrl: imageUrl,
//      );
//    });
//  }
//

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: kLightHighlightColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(100),
                          child: ProfilePicture(),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kHighlightColor,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 15,
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
