import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Misc/constants.dart';

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
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
          color: kVeryLightGrey,
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextField(
          autofocus: autofocus ?? false,
          controller: textEditingController,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(kPadding),
            hintText: kSearchBooksString,
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
