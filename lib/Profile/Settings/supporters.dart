import 'package:flutter/material.dart';

class Supporters extends StatefulWidget {
  @override
  _SupportersState createState() => _SupportersState();
}

class _SupportersState extends State<Supporters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
