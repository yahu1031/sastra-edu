import 'package:flutter/material.dart';
import '../Login/login.dart';
import '../Misc/screens/mailUs.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
