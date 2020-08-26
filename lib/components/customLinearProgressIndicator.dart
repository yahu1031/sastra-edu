import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  final double value;
  final Function loadingFinished;

  const CustomLinearProgressIndicator(
      {Key key, this.value, this.loadingFinished})
      : super(key: key);
  @override
  _CustomLinearProgressIndicatorState createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> valueTween;
  Animation<double> curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );
    valueTween = Tween<double>(
      begin: 0,
      end: widget.value,
    );
    _controller.addListener(() {
      if (widget.value == 1 && _controller.isCompleted) {
        widget.loadingFinished();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      double beginValue =
          valueTween?.evaluate(_controller) ?? oldWidget?.value ?? 0;

      // Update the value tween.
      valueTween = Tween<double>(
        begin: beginValue,
        end: widget.value ?? 1,
      );

      _controller
        ..value = 0
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Container(),
      builder: (context, child) {
        return Container(
          height: 12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: valueTween.evaluate(curve),
            ),
          ),
        );
      },
    );
  }
}
