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
    String isbn,
  ) async {
    if (_list.contains(isbn)) return;
    _list.add(isbn);
    _updateDB();
  }

  static void remove(String isbn) {
    _list.remove(isbn);
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

  static List<String> get list => _list;
}
