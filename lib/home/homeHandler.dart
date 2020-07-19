/*
 * Name: homeHandler
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/navigationDrawer.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/components/buttons/iconButton/children/hamburgerButton.dart';
import 'package:sastra_ebooks/components/profile/profilePicture.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'drawerNavigator.dart';

class HomeHandler extends StatefulWidget {
  static const String id = '/homeHandler';

  final User user;

  const HomeHandler(this.user);

  @override
  _HomeHandlerState createState() => _HomeHandlerState();
}

class _HomeHandlerState extends State<HomeHandler>
    with TickerProviderStateMixin {
  double screenWidth, screenHeight;
  final Duration navigationDrawerDuration = const Duration(milliseconds: 300);

  AnimationController _controller;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    initAnimations();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initAnimations() {
    _controller =
        AnimationController(vsync: this, duration: navigationDrawerDuration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
  }

  void collapseDrawer() {
    setState(() {
      NavigationDrawer.isCollapsed = true;
    });
  }

  Future uploadPic(PickedFile pickedImage) async {
    setState(() => ProfilePicture.updateImage('placeholder'));

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
          .getReferenceFromUrl(widget.user.proPicUrl);

      widget.user.proPicUrl = await taskSnapshot.ref.getDownloadURL();

      Firestore.instance.document("Data/${widget.user.uid}").updateData({
        "pro_pic": widget.user.proPicUrl,
      });
      print(widget.user.proPicUrl);
    }

    print("Profile Picture uploaded");

    oldProPicReference.delete();
    File(pickedImage.path).delete();

    setState(() => ProfilePicture.updateImage(widget.user.proPicUrl));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        title: DrawerNavigator.currentPage.appBarTitle,
        leading: HamburgerButton(
          onPressed: () {
            if (NavigationDrawer.isCollapsed) {
              setState(() {
                NavigationDrawer.isCollapsed = false;
              });
              _controller.forward();
            } else {
              setState(() {
                NavigationDrawer.isCollapsed = true;
              });
              _controller.reverse();
            }
          },
        ),
      ),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            ///--- Screens ---///
            AnimatedPositioned(
              duration: navigationDrawerDuration,
              top: NavigationDrawer.isCollapsed ? 0 : -0.09 * screenHeight,
              bottom: NavigationDrawer.isCollapsed ? 0 : -0.05 * screenHeight,
              left: NavigationDrawer.isCollapsed ? 0 : 150,
              right: NavigationDrawer.isCollapsed ? 0 : -150,
              child: Container(
                width: screenWidth,
                height: screenHeight,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  alignment: Alignment.centerLeft,
                  child: IgnorePointer(
                    ignoring: !NavigationDrawer.isCollapsed,
                    child: Material(
                      animationDuration: navigationDrawerDuration,
                      elevation: 8,
                      color: CustomColors.lightColor,
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: DrawerNavigator.currentPage,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///--- NavigationDrawer ---///
            NavigationDrawer(
              collapseDrawer: collapseDrawer,
              animationController: _controller,
              user: widget.user,
            ),
          ],
        ),
      ),
    );
  }
}
