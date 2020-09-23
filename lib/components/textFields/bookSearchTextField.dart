/*
 Name: bookSearchField
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/buttons/textFieldButton/textFieldButton.dart';
import 'package:sastra_ebooks/components/textFields/searchTextField.dart';

class BookSearchTextField extends StatelessWidget {
  static TextEditingController textEditingController = TextEditingController();
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final TextFieldButton suffixIcon;
  BookSearchTextField({this.onChanged, this.autofocus, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchBooks',
      child: SearchTextField(
        onChanged: onChanged,
        textEditingController: BookSearchTextField.textEditingController,
        autofocus: autofocus,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
