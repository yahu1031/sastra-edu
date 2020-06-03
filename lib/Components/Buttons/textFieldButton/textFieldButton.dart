import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      onTapDown: (TapDownDetails tapDownDetails) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (TapUpDetails tapUpDetails) {
        setState(() {
          _pressed = false;
        });
        widget.onPressed();
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(10),
              highlightColor: widget.highlightColor,
              splashColor: widget.highlightColor,
              child: widget.child);
        },
      ),
    );
  }
}
