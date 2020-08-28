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
import 'package:sastra_ebooks/components/buttons/dropDownButtun/customDropDownButton.dart';
import 'package:sastra_ebooks/components/buttons/dropDownButtun/dropDownButton.dart'
    as custom;
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/login/mailVerification.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart' as dialogs;
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import '../services/auth.dart';

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

  // Todo: maybe put this in the cloud
  static const List<int> schoolYears = [1, 2, 3, 4, 5];
  static const List<String> branches = [
    'Aero Eng',
    'Bio Eng',
    'Bio-Info',
    'Bio-Tech',
    'Che Eng',
    'Civil Eng',
    'CS & Business Sys',
    'CSE',
    'CSE (AI & DS)',
    'CSE (Cyber Sec & Blockchain Tech)',
    'CSE (IoT & Automation)',
    'EEE',
    'EEE (Smart Grid & E-Vehicles)',
    'ECE',
    'ECE (Cyber Physical Systems)',
    'EIE',
    'ICT',
    'IT',
    'Mech Eng',
    'Mec Eng (Digital Manuf)',
    'Mechatronics',
  ];
  int _year = schoolYears[0];
  String _branch = branches[0];

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  void signUp() async {
    if (_formKey.currentState.validate()) {
      dialogs.showLoadingDialog(context);

      if (_regNum.length < 9) {
        Navigator.pop(context);

        dialogs.yesAbortDialog(context, Strings.regNumTooShortString,
            Strings.regNumTooShortExplainString);
      } else if (_password.length < 6) {
        Navigator.pop(context);

        dialogs.yesAbortDialog(context, Strings.passwordTooShortString,
            Strings.passwordTooShortExplainString);
      } else {
        User firebaseUser = await _auth.signUpUser(
          _regNum,
          _password,
        );
        Navigator.pop(context);

        if (firebaseUser == null) {
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text('User already exists, please Login.'),
              actions: [
                FlatButton(
                  child: Text('Close'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
        } else if (firebaseUser != null && !firebaseUser.emailVerified) {
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(firebaseUser.uid)
              .set({
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
      appBar: CustomAppBar(
        context,
        backButton: true,
      ),

      ///*-----SignUp-Form-----*///
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              MediaQuery.of(context).viewInsets.bottom -
              56,
          constraints: BoxConstraints(minHeight: 416),
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.extraLargePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///*-----Title -----*///
              if (!_keyboardVisible)
                LargeHeading(
                  text: 'Sign Up ',
                  highlightText: '.',
                  size: HeadingSize.large,
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
                        Expanded(
                          child: CustomDropDownButton<int>(
                            onChanged: (int value) {
                              setState(() {
                                _year = value;
                              });
                            },
                            value: _year,
                            items: schoolYears
                                .map<custom.DropdownMenuItem<int>>((int value) {
                              return custom.DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.padding,
                        ),
                        Expanded(
                          child: CustomDropDownButton<String>(
                            onChanged: (String value) {
                              setState(() {
                                _branch = value;
                              });
                            },
                            value: _branch,
                            items: branches
                                .map<custom.DropdownMenuItem<String>>(
                                    (String value) {
                              return custom.DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: Dimensions.smallPadding),
                child: RoundedButton(
                  onPressed: signUp,
                  labelText: Strings.kSignup,
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
