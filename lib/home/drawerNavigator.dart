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
  static int _currentPageIndex = 0;

  static void toIndex(int i) {
    if (i == 0)
      _toHome();
    else if (i == 1)
      _toFavorites();
    else if (i == 2) _toBookmarks();
  }

  static void _reset() {
    _currentPageString = Home.id;
    _currentPageIndex = 0;
  }

  static void _toHome() {
    _currentPageString = Home.id;
    _currentPageIndex = 0;
  }

  static void _toFavorites() {
    _currentPageString = Favorite.id;
    _currentPageIndex = 1;
  }

  static void _toBookmarks() {
    _currentPageString = Bookmark.id;
    _currentPageIndex = 2;
  }

//  static void toChat() => _currentPage = Chat.id;

  static String get currentPageString => _currentPageString;
  static int get currentPageIndex => _currentPageIndex;

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
