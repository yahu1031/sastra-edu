/*
 Name: expandedPlaceholder
 Use: 
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';

class ExpandedPlaceholder extends StatelessWidget {
  final int flex;

  const ExpandedPlaceholder({this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(),
    );
  }
}
