/*
 Name: largeHeading
 Use:
 Todo:    - Add Use of this file
            - cleanup
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/buttons/textFieldButton/textFieldButton.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final TextFieldButton suffixIcon;

  SearchTextField({
    @required this.onChanged,
    this.textEditingController,
    this.suffixIcon,
  });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
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
          autofocus: false,
          controller: widget.textEditingController,
          textAlign: TextAlign.left,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dimensions.padding),
            hintText: Strings.searchBooksString,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ),
    );
  }
}
