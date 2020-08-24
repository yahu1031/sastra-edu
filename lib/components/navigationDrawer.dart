/*
 * Name: navigationDrawer
 * Use:
 * TODO:    - Add Use of this file
            - better solution for setting state in home
            - inkwell not displayed above the profile picture
            - home is still animated when popping profile
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sastra_ebooks/components/buttons/menuButton.dart';
import 'package:sastra_ebooks/components/customInkWell.dart';
import 'package:sastra_ebooks/home/drawerNavigator.dart';
import 'package:sastra_ebooks/home/screens/bookmark.dart';
import 'package:sastra_ebooks/home/screens/favorite.dart';
import 'package:sastra_ebooks/home/screens/home.dart';
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/profile/profile.dart';
import 'package:sastra_ebooks/services/auth.dart';
import 'package:sastra_ebooks/services/dialogs.dart';
import 'package:sastra_ebooks/components/profile/profilePicture.dart';
import 'package:sastra_ebooks/services/user.dart';

import 'expandedPlaceholder.dart';

class NavigationDrawer extends StatefulWidget {
  static bool isCollapsed = true;

  final Function collapseDrawer;
  final AnimationController animationController;
  final User user;

  const NavigationDrawer({
    @required this.collapseDrawer,
    @required this.animationController,
    @required this.user,
  });

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final AuthServices _auth = AuthServices();

  Animation<Offset> _slideAnimation;
  Animation<double> _menuScaleAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  void initAnimations() {
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(widget.animationController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(widget.animationController);
  }

  void closeNavDrawer() {
    widget.animationController.reverse();
    widget.collapseDrawer();
  }

  void onProfilePicturePressed() async {
    final Future isUploadingProPic =
        Navigator.pushNamed(context, Profile.id, arguments: widget.user);
    await Future.delayed(Duration(milliseconds: 300));
    closeNavDrawer();
    await isUploadingProPic;
    setState(() {});
  }

  void onHomePressed() {
    setState(() {
      DrawerNavigator.toHome();
    });
    closeNavDrawer();
  }

  void onFavoritePressed() {
    setState(() {
      DrawerNavigator.toFavorites();
    });
    closeNavDrawer();
  }

  void onBookmarksPressed() {
    setState(() {
      DrawerNavigator.toBookmarks();
    });
    closeNavDrawer();
  }

  void onProfilePressed() async {
    Navigator.pushNamed(context, Profile.id, arguments: widget.user);
    await Future.delayed(Duration(milliseconds: 300));
    closeNavDrawer();
  }

  void onChatPressed() {
    Dialogs.codingDialog(context);
  }

  void onLogOutPressed() async {
    await _auth.signOut();
    closeNavDrawer();
    DrawerNavigator.reset();
    Navigator.pushNamedAndRemoveUntil(context, Login.id, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          width: 150,
          child: Column(
            children: <Widget>[
              ExpandedPlaceholder(),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ExpandedPlaceholder(),
                    Expanded(
                      flex: 12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuButton(
                            onPressed: onHomePressed,
                            icon: OMIcons.home,
                            selected:
                                DrawerNavigator.currentPageString == Home.id
                                    ? true
                                    : false,
                          ),
                          MenuButton(
                            onPressed: onFavoritePressed,
                            icon: Icons.favorite_border,
                            selected:
                                DrawerNavigator.currentPageString == Favorite.id
                                    ? true
                                    : false,
                          ),
                          MenuButton(
                            onPressed: onBookmarksPressed,
                            icon: Icons.bookmark_border,
                            selected:
                                DrawerNavigator.currentPageString == Bookmark.id
                                    ? true
                                    : false,
                          ),
                          MenuButton(
                            onPressed: onProfilePressed,
                            icon: Icons.person_outline,
                            selected: false,
                          ),
//                          MenuButton(
//                            //onPressed: onChatPressed,
//                            icon: Icons.chat_bubble_outline,
//                            selected: DrawerNavigator.currentPage == Chat.id
//                              ? true
//                              : false,
//                          ),
                          MenuButton(
                            onPressed: onLogOutPressed,
                            icon: Icons.power_settings_new,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ExpandedPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }
}
