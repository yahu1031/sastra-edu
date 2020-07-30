/*
 * Name: bookmarks
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmarks {
  static Map<String, List> _map = {};
  static String _userId;

  static void init(String userId, Map<String, List> bookmarks) {
    print(bookmarks);
    _userId = userId;
    _map = bookmarks;
  }

  static void add(String bookId, int page) {
    print(page.toString());

    if (_map.containsKey(bookId)) {
      if (_map[bookId].contains(page)) {
      } else {
        _map[bookId].add(page);
        _map[bookId].sort();
      }
    } else {
      _map[bookId] = [page];
    }
    _updateDB();
  }

  static void remove(String bookId, int page) {
    print(page.toString());
    if (_map.containsKey(bookId)) {
      if (_map[bookId].contains(page)) {
        _map[bookId].remove(page);
        if (_map[bookId].isEmpty) {
          _map.remove(bookId);
          _updateDB();
        }
      }
    }
  }

  static void _updateDB() async {
    await Firestore.instance.collection('Data').document(_userId).updateData({
      'bookmarks': _map,
    });
  }

  static get map => _map;
}
