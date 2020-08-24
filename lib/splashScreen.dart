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
import 'package:sastra_ebooks/login/autentication.dart';
import 'package:sastra_ebooks/services/images.dart';

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

    if (_firebaseUser != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoadingScreen.id, (route) => false,
          arguments: _firebaseUser);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
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
