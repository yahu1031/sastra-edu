import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final bool autofocus;

  SearchTextField({
    this.onChanged,
    this.textEditingController,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchBooks',
      child: Material(
        child: Container(
          padding: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            autofocus: autofocus ?? false,
            controller: textEditingController,
            textAlign: TextAlign.left,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search for books',
              hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
              border: InputBorder.none,
              fillColor: Colors.grey.withOpacity(0.5),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
