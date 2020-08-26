/*
 * Name: bookmarks
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class Bookmarks {
  static Map _map = {};
  static String _userId;

  static void init(String userId, Map bookmarks) {
    _userId = userId;
    _map = bookmarks;
  }

  static void update(Map bookmarks) {
    _map = bookmarks;
  }

  static void add(String bookId, int page, String name, String chapter) async {
    DocumentSnapshot bookmarksSnapshot = await _getDB();
    Map bookmarkData = bookmarksSnapshot.data();
    Map bookmarks = bookmarkData['bookmarks'] ?? {};
    print(bookmarks);
    if (bookmarks.containsKey(bookId)) {
      for (Map bookmark in bookmarks[bookId]) {
        if (bookmark.containsKey(page)) {
          return;
        }
      }
      bookmarks[bookId].add({'page': page, 'name': name, 'chapter': chapter});
    } else {
      bookmarks[bookId] = [
        {'page': page, 'name': name, 'chapter': chapter}
      ];
    }

    update(bookmarks);
    _updateDB(bookmarks);
  }

  static void remove(String bookId, int page) async {
    DocumentSnapshot bookmarksSnapshot = await _getDB();
    Map bookmarkData = bookmarksSnapshot.data();

    Map bookmarks = bookmarkData['bookmarks'];

    if (bookmarks[bookId] != null) {
      if (bookmarks[bookId].length == 1) {
        bookmarks.remove(bookId);
      } else {
        for (int i = 0; i < bookmarks[bookId].length; i++) {
          if (bookmarks[bookId][i]['page'] == page) {
            bookmarks[bookId].removeAt(i);
            break;
          }
        }
      }
    }
    update(bookmarks);
    _updateDB(bookmarks);
  }

  static Future<DocumentSnapshot> _getDB() async =>
      await (FirebaseFirestore.instance
          .collection('userData')
          .doc(_userId)
          .get());

  static void _updateDB(Map bookmarks) async {
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(_userId)
        .update({
      'bookmarks': bookmarks,
    });
  }

  static get map => _map;
}
