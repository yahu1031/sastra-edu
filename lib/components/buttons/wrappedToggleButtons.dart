/*
 * Name: WrappedToggleButtons
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class WrappedToggleButtons extends StatefulWidget {
  final List<Widget> children;
  final List<bool> isSelected;
  final Function(int index) onPressed;

  WrappedToggleButtons({
    @required this.children,
    @required this.isSelected,
    @required this.onPressed,
  }) : assert(children.length == isSelected.length);

  @override
  _WrapToggleButtonsState createState() => _WrapToggleButtonsState();
}

class _WrapToggleButtonsState extends State<WrappedToggleButtons> {
  int index;

  @override
  Widget build(BuildContext context) {
    index = -1;
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 30,
      runSpacing: 30,
      children: widget.children.map((Widget child) {
        index++;
        return _ToggleButton(
          active: widget.isSelected[index],
          child: child,
          onTap: widget.onPressed,
          index: index,
        );
      }).toList(),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final bool active;
  final Widget child;
  final Function onTap;
  final int width;
  final int height;
  final int index;

  _ToggleButton({
    @required this.active,
    @required this.child,
    @required this.onTap,
    @required this.index,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: Dimensions.borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: active ? CustomColors.lightHighlightColor : null,
          border: Border.all(
            color:
                active ? CustomColors.highlightColor : CustomColors.middleGrey,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: Dimensions.borderRadius,
        ),
        child: child,
      ),
    );
  }
}
