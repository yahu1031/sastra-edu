import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem> items;
  const CustomDropDownButton({Key key, this.value, this.onChanged, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40 * SizeConfig.widthMultiplier,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: CustomColors.veryLightGrey,
        borderRadius: Dimensions.borderRadius,
      ),
      child: DropdownButton<T>(
        value: value,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        underline: Container(),
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}
