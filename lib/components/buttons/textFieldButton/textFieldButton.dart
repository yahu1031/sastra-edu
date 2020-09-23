/*
 Name: textFieldButton
 Use:
 Todo:    - Add Use of this file
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';

class TextFieldButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color highlightColor;
  final Widget child;

  TextFieldButton({
    @required this.onPressed,
    highlightColor,
    this.child,
  }) : this.highlightColor = highlightColor ?? Colors.grey.withOpacity(.3);

  @override
  _TextFieldButtonState createState() => _TextFieldButtonState();
}

class _TextFieldButtonState extends State<TextFieldButton> {
  VoidCallback onPressed;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();

    onPressed = () {
      widget.onPressed();
      setState(() {
        _pressed = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails tapUpDetails) {
        setState(() {
          _pressed = !_pressed;
        });
        widget.onPressed();
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.minHeight,
            height: constraints.minHeight,
            child: Align(
              alignment: Alignment.center,
              child: AnimatedContainer(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: Dimensions.borderRadius,
                  color: _pressed ? widget.highlightColor : Colors.transparent,
                ),
                duration: Duration(milliseconds: 200),
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
}
