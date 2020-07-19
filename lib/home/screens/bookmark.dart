/*
 * Name: bookmark
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/bookmarkIconTitle.dart';

class Bookmark extends StatefulWidget {
  static const String id = '/bookmark';
  final appBarTitle = BookmarkIconTitle();

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
