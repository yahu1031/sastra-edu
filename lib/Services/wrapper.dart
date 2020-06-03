import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import '../Services/authenticate.dart';
import '../Services/user.dart';

class Wrapper extends StatefulWidget {
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
      return LoadingScreen(user);
    }
  }
}
