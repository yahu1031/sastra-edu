import 'package:flutter/cupertino.dart';

import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/textFields/searchTextField.dart';

class BookSearchTextField extends StatelessWidget {
  static TextEditingController textEditingController = TextEditingController();
  final ValueChanged<String> onChanged;
  final bool autofocus;

  BookSearchTextField({this.onChanged, this.autofocus});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'searchBooks',
      child: SearchTextField(
        onChanged: onChanged,
        textEditingController: BookSearchTextField.textEditingController,
        autofocus: autofocus,
      ),
    );
  }
}
