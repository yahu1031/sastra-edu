import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/hamburgerButton.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/navigationDrawer.dart';
import 'package:sastra_ebooks/Home/drawerNavigator.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

class HomeHandler extends StatefulWidget {
  static const String id = '/homeHandler';

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

//  Widget getAppBarTitle() {
//    if (DrawerNavigator.currentPageString == Bookmark.id) {
//      return BookmarkTitle();
//    } else if (DrawerNavigator.currentPageString == Favorite.id) {
//      return FavoriteTitle();
//    }
//    return AppTitle('M-Book Edu');
//  }

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
              left: NavigationDrawer.isCollapsed ? 0 : 100,
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
                      color: kLightColor,
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
              collapseDrawer,
              animationController: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
