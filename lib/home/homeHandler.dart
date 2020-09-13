/*
  Name: homeHandler
  Use:
  Todo:    - Add Use of this file
            - cleanup
 */

import 'dart:ui';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/modal_bottom_sheet/lib/src/bottom_sheets/material_bottom_sheet.dart';
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
  @override
  Widget build(BuildContext context) {
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
            radius: 50,
            child: Container(
                width: 43,
                height: 43,
                child: SvgPicture.asset(Images.babyYoda)),
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
