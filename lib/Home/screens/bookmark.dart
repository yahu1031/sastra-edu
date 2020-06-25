import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/bookmarkTitle.dart';

class Bookmark extends StatefulWidget {
  static const String id = '/bookmark';
  final appBarTitle = BookmarkTitle();

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
