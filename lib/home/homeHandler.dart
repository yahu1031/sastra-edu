/*
 * Name: homeHandler
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'dart:ui';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:package_info/package_info.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/profileModalBottomSheet.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'drawerNavigator.dart';

class HomeHandler extends StatefulWidget {
  static const String id = '/homeHandler';

  final UserData user;

  const HomeHandler(this.user);

  @override
  _HomeHandlerState createState() => _HomeHandlerState();
}

class _HomeHandlerState extends State<HomeHandler>
    with TickerProviderStateMixin {
  double screenWidth, screenHeight;
  final Duration navigationDrawerDuration = const Duration(milliseconds: 300);

  AnimationController _controller;
  PackageInfo packageInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return CustomScaffold(
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: DrawerNavigator.currentPageIndex,
        onTap: (index) {
          setState(() {
            DrawerNavigator.toIndex(index);
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Color(0xFF40C4FF),
            icon: Icon(
              OMIcons.home,
              color: Colors.lightBlueAccent,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Color(0xFF40C4FF),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: Color(0xFF40C4FF),
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.redAccent,
            icon: Icon(
              Icons.favorite_border,
              color: Colors.redAccent,
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(
              Icons.bookmark_border,
              color: Colors.blue,
            ),
            activeIcon: Icon(
              Icons.bookmark,
              color: Colors.blue,
            ),
            title: Text(
              "Bookmarks",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        highlightElevation: 0,
        hoverElevation: 0,
        elevation: 2,
        foregroundColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        onPressed: () {
          showMaterialModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.borderRadiusDouble),
              ),
            ),
            context: context,
            builder: (BuildContext context, _) {
              return ProfileModalBottomSheet(user: widget.user);
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.transparent,
            radius: 30,
            backgroundImage: AssetImage(Images.kLoginPic),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Padding(
        padding: EdgeInsets.only(top: Dimensions.padding),
        child: DrawerNavigator.currentPage,
      ),
    );
  }
}
