import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

import 'dropDownButton.dart' as custom;

class CustomDropDownButton<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final Alignment innerItemAlignment;
  final List<custom.DropdownMenuItem> items;
  const CustomDropDownButton(
      {Key key,
      this.value,
      this.onChanged,
      this.items,
      this.innerItemAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: CustomColors.veryLightGrey,
        borderRadius: Dimensions.borderRadius,
      ),
      child: custom.DropdownButton<T>(
        value: value,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.black,
        ),
        underline: Container(),
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
