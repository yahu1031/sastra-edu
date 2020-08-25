/*
 * Name: profile
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/customAboutDialog.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/listItem.dart';
import 'package:sastra_ebooks/components/profile/profileInfoCard.dart';
import 'package:sastra_ebooks/components/profile/profilePicture.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/screens/mailUs.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:package_info/package_info.dart';
import 'package:sastra_ebooks/profile/settingScreens/credits.dart';
import 'package:sastra_ebooks/profile/settingScreens/downloadsPayment.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'settingScreens/about.dart';
import '../services/dialogs.dart';

class Profile extends StatefulWidget {
  static const String id = '/profile';

  final User user;

  Profile(this.user);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future uploadingPicInProgress;
  bool isPopping = false;

  @override
  Widget build(BuildContext context) {
    void onPop() {
      isPopping = true;
      Navigator.pop(context, uploadingPicInProgress);
    }

    return WillPopScope(
      onWillPop: () {
        onPop();
        return Future.value(true);
      },
      child: CustomScaffold(
        appBar: CustomAppBar(
          context,
          backButton: true,
          onBackButtonPressed: onPop,
          title: AppBarTitle('Profile'),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Center(
                    child: ProfileInfoCard(widget.user),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListItem(
                      onPressed: () => Navigator.pushNamed(context, MailUs.id),
                      title: Strings.supportString,
                      icon: Icons.feedback,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    ListItem(
                      onPressed: () => Navigator.pushNamed(context, AboutUs.id),
                      title: Strings.aboutUsString,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                    ListItem(
                      onPressed: () =>
                          Navigator.pushNamed(context, DownloadPayment.id),
                      title: Strings.getPremiumString,
                      icon: Icons.credit_card,
//                    SvgPicture.asset(
//                      Images.coke,
//                      color: Colors.lightBlueAccent,
//                      height: 20.0,
//                    ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                // onTap: () => Navigator.pushNamed(context, Credits.id),
                onTap: () async {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  showDialog(
                    context: context,
                    child: CustomAboutDialog(
                      applicationIcon: Image.asset(
                        Images.appIcon,
                        fit: BoxFit.fitWidth,
                        width: 100,
                      ),
                      applicationName: packageInfo.appName,
                      applicationVersion: packageInfo.version,
                      applicationLegalese: 'IMPLEMENT',
                    ),
                  );

                  // showAboutDialog(
                  //     context: context,
                  //     applicationIcon: Image.asset(
                  //       Images.appIcon,
                  //       fit: BoxFit.fitWidth,
                  //       width: 100,
                  //     ),
                  //     applicationName: packageInfo.appName,
                  //     applicationVersion: packageInfo.version,
                  //     applicationLegalese: 'IMPLEMENT',
                  //     children: [Text('asdsd')]);
                },

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    Images.info,
                    color: CustomColors.highlightColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
