/*
 * Name: drawerNavigator
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:sastra_ebooks/home/screens/bookmark.dart';
import 'package:sastra_ebooks/home/screens/favorite.dart';

import 'screens/home.dart';

class DrawerNavigator {
  static String _currentPageString = Home.id;

  static void reset() => _currentPageString = Home.id;

  static void toHome() => _currentPageString = Home.id;

  static void toFavorites() => _currentPageString = Favorite.id;

  static void toBookmarks() => _currentPageString = Bookmark.id;

//  static void toChat() => _currentPage = Chat.id;

  static get currentPageString => _currentPageString;

  static get currentPage {
    if (_currentPageString == Home.id) {
      return Home();
    } else if (_currentPageString == Favorite.id) {
      return Favorite();
    } else if (_currentPageString == Bookmark.id) {
      return Bookmark();
    }
  }
}
