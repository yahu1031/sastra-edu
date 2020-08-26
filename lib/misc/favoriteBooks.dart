/*
 * Name: favorite
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteBooks {
  static List<String> _list = [];
  static String _userId;

  static void init(String userId, List<String> favoriteBooks) {
    _userId = userId;
    _list = favoriteBooks;
  }

  static void update(List<String> favoriteBooks) {
    _list = favoriteBooks;
  }

  static void add(
    String bookId,
  ) async {
    if (_list.contains(bookId)) return;
    _list.add(bookId);
    _updateDB();
  }

  static void remove(String bookId) {
    _list.remove(bookId);
    _updateDB();
  }

  static void _updateDB() async {
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(_userId)
        .update({
      'favoriteBooks': _list,
    });
  }

  static get list => _list;
}
