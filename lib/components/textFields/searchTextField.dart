/*
 * Name: largeHeading
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final bool autofocus;

  SearchTextField({
    @required this.onChanged,
    this.textEditingController,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Dimensions.borderRadius,
      child: Container(
        padding: EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          color: CustomColors.veryLightGrey,
          borderRadius: Dimensions.borderRadius,
        ),
        child: TextField(
          autofocus: autofocus ?? false,
          controller: textEditingController,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dimensions.padding),
            hintText: Strings.searchBooksString,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
