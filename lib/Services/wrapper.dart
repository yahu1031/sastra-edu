import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sastra_ebooks/Login/login.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import '../Services/user.dart';

class Wrapper extends StatelessWidget {
  static const id = '/';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //Return to home or Authentication Widget
    if (user == null) {
      return Login();
    } else {
      return LoadingScreen(user);
    }
  }
}
