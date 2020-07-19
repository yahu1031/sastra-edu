/*
 * Name: favorite
 * Use:
 * TODO:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/appBarTitles/children/iconTitles/children/favoriteIconTitle.dart';

class Favorite extends StatefulWidget {
  static const String id = '/favorite';
  final appBarTitle = FavoriteIconTitle();

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
