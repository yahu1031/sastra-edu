///*
// * Name: iconToggleButton
// * Use:
// * TODO:    - Add Use of this file
// */
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:sastra_ebooks/misc/dimensions.dart';
//
//class IconToggleButton extends StatefulWidget {
//  final IconData activeIcon;
//  final IconData disabledIcon;
//  final VoidCallback onActivate;
//  final VoidCallback onDisable;
//
//  final Color activeColor;
//  final Color disableColor;
//  final bool isActive;
//  final String id;
//
//  IconToggleButton({
//    @required this.activeIcon,
//    @required this.disabledIcon,
//    @required this.onActivate,
//    @required this.onDisable,
//    this.activeColor,
//    this.disableColor,
//    this.isActive,
//    this.id,
//  });
//
//  @override
//  _IconToggleButtonState createState() => _IconToggleButtonState();
//}
//
//class _IconToggleButtonState extends State<IconToggleButton> {
//  bool isActive;
//
//  @override
//  void initState() {
//    super.initState();
//    isActive = widget.isActive ?? false;
//    print('isActive1 - ${widget.id}: ${isActive}');
//    print('isActive - ${widget.id}: ${widget.isActive}');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: () {
//        if (isActive) {
//          widget.onDisable();
//        } else if (!isActive) {
//          widget.onActivate();
//        }
//        setState(() {
//          isActive = !isActive;
//        });
//      },
//      borderRadius: Dimensions.borderRadius,
//      child: SizedBox(
//        width: 50,
//        height: 50,
//        child: Center(
//          child: Icon(
//            isActive ? widget.activeIcon : widget.disabledIcon,
//            color: isActive ? widget.activeColor : widget.disableColor,
//          ),
//        ),
//      ),
//    );
//  }
//}
