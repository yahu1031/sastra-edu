import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:sastra_ebooks/splashscreen.dart';
import '../Services/authenticate.dart';
import '../Services/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var user2;
=======
import 'package:sastra_ebooks/Login/login.dart';
import 'package:sastra_ebooks/loadingScreen.dart';

import '../Services/user.dart';

class Wrapper extends StatelessWidget {
  static const id = '/';
>>>>>>> master

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //Return to home or Authentication Widget
    if (user == null) {
<<<<<<< HEAD
      return Authenticate();
    } else {
      user2 = user;
      return Splash(user);
=======
      return Login();
    } else {
      return LoadingScreen(user);
>>>>>>> master
    }
  }
}
