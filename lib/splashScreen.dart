/*
 Name: splashScreen
 Use: 
 Todo:    - Add Use of this file
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/login/mailVerification.dart';

class SplashScreen extends StatefulWidget {
  static const id = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool isLoggedIn;

  double value;

  @override
  void initState() {
    super.initState();

    authenticate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  authenticate() async {
    await Firebase.initializeApp();

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User _firebaseUser = _firebaseAuth.currentUser;

    if (_firebaseUser == null) {
      Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
    } else if (!_firebaseUser.emailVerified) {
      Navigator.pushNamed(
        context,
        EmailVerification.id,
      );
    } else if (_firebaseUser != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoadingScreen.id, (route) => false,
          arguments: _firebaseUser);
    } else {
      dialogs.yesAbortDialog(context, Strings.errorString,
          "Ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: .8,
          child: Image.asset(Images.appIcon),
        ),
      ),
    );
  }
}
