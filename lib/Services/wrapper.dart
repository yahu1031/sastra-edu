import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Home/Home.dart';
import '../Home/Home.dart';
import '../Services/authenticate.dart';
import '../Services/user.dart';

class Wrapper extends StatefulWidget {
  final data;
  Wrapper(this.data);
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var user2;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //Return to home or Authentication Widget
    if (user == null) {
      return Authenticate();
    } else {
      user2 = user;
      return Home(widget.data);
    }
  }
}
