import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// Todo: clean up

class BookmarkIconTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue,
      highlightColor: Colors.lightBlueAccent[100],
      child: Container(
        child: new Icon(
          Icons.bookmark,
          size: 30.0,
        ),
      ),
    );
  }
}
