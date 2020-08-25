/*
 * Name: login
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
            - re-add dialogs
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/buttons/dropDownButton.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/login/login.dart';
import 'package:sastra_ebooks/login/mailVerification.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/buttons/tappableText.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart' as dialogs;
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/services/user.dart';
import '../misc/screens/mailUs.dart';
import '../services/auth.dart';
import 'forgotpassword.dart';

class SignUp extends StatefulWidget {
  static const id = '/signUpScreen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  String _regNum, _password, _name;
  bool onEnableLogin = false;
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  static const List<int> schoolYears = [1, 2, 3, 4];
  static const List<String> branches = [
    'Computer Science',
    'a',
    'b',
  ];
  int _year = schoolYears[0];
  String _branch = branches[0];

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  void signUp() async {
    dialogs.showLoadingDialog(context);

    if (_formKey.currentState.validate()) {
      if (_regNum.length < 9) {
        Navigator.pop(context);

        dialogs.yesAbortDialog(context, Strings.regNumTooShortString,
            Strings.regNumTooShortExplainString);
      } else if (_password.length < 6) {
        Navigator.pop(context);

        dialogs.yesAbortDialog(context, Strings.passwordTooShortString,
            Strings.passwordTooShortExplainString);
      } else {
        FirebaseUser firebaseUser = await _auth.signUpUser(
          _regNum,
          _password,
        );
        Navigator.pop(context);

        if (firebaseUser == null) {
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text('Something went wrong. Try again'),
                actions: [
                  FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
        } else if (firebaseUser != null && !firebaseUser.isEmailVerified) {
          await Firestore.instance
              .collection('userData')
              .document(firebaseUser.uid)
              .setData({
            "name": _name,
            "branch": _branch,
            "year": _year,
            "regNo": _regNum,
            'favoriteBooks': [],
            'bookmarks': {},
          });

          Navigator.pushNamed(
            context,
            EmailVerification.id,
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _keyboardVisible = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
        });
      },
    );
  }

  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomPadding: true,

      ///*-----SignUp-Form-----*///
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).viewInsets.bottom,
            constraints: BoxConstraints(minHeight: 416),
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.extraLargePadding),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///*-----Title -----*///
                  if (!_keyboardVisible)
                    LargeHeading(
                      text: 'Sign\nUp',
                      highlightText: ' .',
                      size: HeadingSize.extraLarge,
                    ),

                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),

                        ///*-----TextFormFields-----*///
                        RegNumTextFormField(
                          onChanged: (String _input) => _regNum = _input,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        ///*-----Password-----*///
                        PasswordTextFormField(
                          onChanged: (String _input) => _password = _input,
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        CustomTextFormField(
                          onChanged: (String _input) => _name = _input,
                          labelText: Strings.kName,
                          validator: (String _input) {
                            if (_input.isEmpty) {
                              return Strings.nameFieldEmptyString;
                            }
                            return null;
                          },
                          autovalidate: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDropDownButton<int>(
                              onChanged: (int value) {
                                setState(() {
                                  _year = value;
                                });
                              },
                              value: _year,
                              items: schoolYears
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                            CustomDropDownButton<String>(
                              onChanged: (String value) {
                                setState(() {
                                  _branch = value;
                                });
                              },
                              value: _branch,
                              items: branches.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  RoundedButton(
                    onPressed: signUp,
                    labelText: Strings.kSignup,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
