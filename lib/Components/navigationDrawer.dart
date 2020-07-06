import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/MenuButton.dart';
import 'package:sastra_ebooks/Components/profilePicture.dart';
import 'package:sastra_ebooks/Home/drawerNavigator.dart';
import 'package:sastra_ebooks/Home/screens/bookmark.dart';
import 'package:sastra_ebooks/Home/screens/favorite.dart';
import 'package:sastra_ebooks/Home/screens/home.dart';
import 'package:sastra_ebooks/Login/login.dart';
import 'package:sastra_ebooks/Profile/profile.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';

/* Todo: - better solution for setting state in home
         - inkwell not displayed above the profile picture
         - home is still animated when popping profile
*/

class NavigationDrawer extends StatefulWidget {
  static bool isCollapsed = true;

  final AnimationController animationController;
  final Function collapse;

  const NavigationDrawer(this.collapse, {@required this.animationController});

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

    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(widget.animationController);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(widget.animationController);
  }

  void closeNavDrawer() {
    widget.animationController.reverse();

    widget.collapse();
  }

  void onProfilePicturePressed() async {
    await Navigator.pushNamed(context, Profile.id);
    print(widget.animationController.value);
    widget.animationController.reset();
    print(widget.animationController.value);
    widget.collapse();
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

  void onChatPressed() {
    Dialogs.codingDialog(context);
  }

  void onLogOutPressed() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, Login.id);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          width: 100,
          //color: Colors.red,
          child: Center(
            child: FractionallySizedBox(
              heightFactor: .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: onProfilePicturePressed,
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      margin: EdgeInsets.all(7),
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(100),
                        child: ProfilePicture(),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuButton(
                          onPressed: onHomePressed,
                          icon: Icons.home,
                          selected: DrawerNavigator.currentPageString == Home.id
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
                          onPressed: () {},
                          icon: Icons.chat_bubble_outline,
//                          selected: DrawerNavigator.currentPage == Chat.id
//                              ? true
//                              : false,
                        ),
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
          ),
        ),
      ),
    );
  }
}
