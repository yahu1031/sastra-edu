/*
 Name: favorite
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/emptyListPlaceholder.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class ListScreen extends StatefulWidget {
  static const String id = '/favorite';

  final Heading heading;
  final String placeholderString;
  final List<Widget> listItems;
  final bool isEmpty;

  const ListScreen({
    Key key,
    @required this.heading,
    @required this.placeholderString,
    @required this.listItems,
    @required this.isEmpty,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.isEmpty)
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
              child: EmptyListPlaceholder(widget.placeholderString)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
                child: widget.heading),
            SizedBox(
              height: Dimensions.largePadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.padding),
                      child: Column(
                        children: widget.listItems,
                      ),
                    ),
                    SizedBox(
                      height: 56,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
