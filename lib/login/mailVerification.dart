import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/services/lottieAnimations.dart';

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
    _firebaseUser = _firebaseAuth.currentUser;
    _firebaseUser.sendEmailVerification();

    while (!verified) {
      await _firebaseUser.reload();
      _firebaseUser = FirebaseAuth.instance.currentUser;
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
            child: FractionallySizedBox(
              widthFactor: .5,
              child: Lottie.asset(
                LottieAnimations.emailVerification,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.extraLargePadding * 2,
          ),
          RoundedButton(
            labelText: 'Re-Send Email',
            onPressed: () => _firebaseUser.sendEmailVerification(),
          ),
          SizedBox(
            height: Dimensions.largePadding * 2,
          ),
          TappableSubtitle(
            descriptionText: 'Wrong Reg Num?',
            actionText: 'Cancel',
            onActionTap: () async {
              await FirebaseFirestore.instance
                  .collection('user_data')
                  .doc(_firebaseUser.uid)
                  .delete();
              // ToDo: delete firebase user
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
