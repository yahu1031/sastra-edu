import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  static const id = '/favorite';

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
