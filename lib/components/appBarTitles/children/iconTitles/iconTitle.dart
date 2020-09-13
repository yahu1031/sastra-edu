/*
 Name: iconTitle
 Use:
 Todo:    - Add Use of this file
            - clean up
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookmarkTitle extends StatelessWidget {
  final IconData icon;

  const BookmarkTitle({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blue,
      highlightColor: Colors.lightBlueAccent[100],
      child: Container(
        child: new Icon(
          icon,
          size: 30.0,
        ),
      ),
    );
  }
}
