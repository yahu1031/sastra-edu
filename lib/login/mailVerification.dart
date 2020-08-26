import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';

class EmailVerification extends StatefulWidget {
  static const id = '/mailVerification';

  const EmailVerification({Key key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  FirebaseAuth _firebaseAuth;
  User _firebaseUser;
  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
    verifying();
  }

  void verifying() async {
    bool verified = false;
    _firebaseUser = await _firebaseAuth.currentUser;
    _firebaseUser.sendEmailVerification();

    while (!verified) {
      await _firebaseUser.reload();
      _firebaseUser = await FirebaseAuth.instance.currentUser;
      print('1');
      if (_firebaseUser.emailVerified) {
        print('2');
        verified = true;
        Navigator.pushNamed(context, LoadingScreen.id,
            arguments: _firebaseUser);
      }
      await Future.delayed(Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Lottie.asset(Jsons.kemailVerification,height: 100,),
          ),
          SizedBox(
            height: Dimensions.largePadding,
          ),
          RoundedButton(
            labelText: 'Re-Send Email',
            onPressed: () => _firebaseUser.sendEmailVerification(),
          ),
          SizedBox(
            height: Dimensions.largePadding,
          ),
          TappableSubtitle(
            descriptionText: 'Wrong Reg Num?',
            actionText: 'Cancel',
            onActionTap: () async {
              await FirebaseFirestore.instance
                  .collection('userData')
                  .doc(_firebaseUser.uid)
                  .delete();
              await _firebaseUser.delete();
              Navigator.pop(
                  context);
            },
          )
        ],
      ),
    );
  }
}
