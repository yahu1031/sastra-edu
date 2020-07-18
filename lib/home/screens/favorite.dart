import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/favoriteTitle.dart';

class Favorite extends StatefulWidget {
  static const String id = '/favorite';
  final appBarTitle = FavoriteTitle();

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
