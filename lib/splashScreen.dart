/*
 * Name: splashScreen
 * Use: 
 * TODO:    - Add Use of this file
 */

import 'package:firebase_auth/firebase_auth.dart';
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

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoggedIn;
  @override
  void initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    final FirebaseUser _firebaseUser = await _firebaseAuth.currentUser();

    if (_firebaseUser == null) {
      Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
    } else if (!_firebaseUser.isEmailVerified) {
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
