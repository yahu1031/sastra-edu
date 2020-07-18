import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteIconTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.redAccent[100],
      child: Container(
        child: new Icon(
          Icons.favorite,
          size: 30.0,
        ),
      ),
    );
  }
}
