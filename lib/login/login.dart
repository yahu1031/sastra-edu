/*
 * Name: login
 * Use:
 * TODO:    - Add Use of this file
            - cleanup
            - re-add dialogs
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/login/signup.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';
import 'package:sastra_ebooks/components/buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/components/buttons/tappableText.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'package:sastra_ebooks/dialogs/loadingDialog.dart' as dialogs;
import 'package:sastra_ebooks/dialogs/dialogs.dart' as dialogs;
import '../services/auth.dart';
import 'forgotpassword.dart';
import 'mailVerification.dart';

class Login extends StatefulWidget {
  static const id = '/loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String _regNum, _password;
  bool onEnableLogin = false;
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  void logIn() async {
    // TODO: add case for unverified email
    if (_formKey.currentState.validate()) {
      dialogs.showLoadingDialog(context);
      final User _firebaseUser = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context, true);
      if (_regNum == null ||
          _password == null ||
          _regNum == null && _password == null) {
        dialogs.yesAbortDialog(
            context, Strings.sorryString, Strings.credentialsMissingString);
      } else if (_regNum.length < 9) {
        dialogs.yesAbortDialog(context, Strings.regNumTooShortString,
            Strings.regNumTooShortExplainString);
      } else if (_password.length < 6) {
        dialogs.yesAbortDialog(context, Strings.passwordTooShortString,
            Strings.passwordTooShortExplainString);
      } else if (_firebaseUser == null) {
        dialogs.yesAbortDialog(context, Strings.sorryString,
            Strings.invalidCredentialsExplainString);
        print('Invalid Credentials');
      } else if (!_firebaseUser.emailVerified) {
        Navigator.pushNamed(
          context,
          EmailVerification.id,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, LoadingScreen.id, (route) => false,
            arguments: _firebaseUser);
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

      ///*-----Login-Form-----*///
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.extraLargePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///*-----Title -----*///
              Container(
                child: (SizeConfig.heightMultiplier < 7 && !_keyboardVisible) ||
                        SizeConfig.heightMultiplier >= 7
                    ? Expanded(
                        flex: 10,
                        child: Container(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: LargeHeading(
                                text: 'Hello There ',
                                highlightText: '.',
                                size: HeadingSize.large,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 5,
                        child: Container(),
                      ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                  ],
                ),
              ),

              Expanded(
                flex: _keyboardVisible ? 5 : 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ///*-----Forgot Password-----*///
                    Container(
                      child: !_keyboardVisible
                          ? Expanded(
                              flex: 4,
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 1 * SizeConfig.heightMultiplier,
                                    ),
                                    child: TappableText(
                                      Strings.forgotPasswordString,
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        ForgotPassword.id,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),

                    ///*-----Login Button-----*///
                    Expanded(
                      flex: 10,
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          child: RoundedButton(
                            onPressed: logIn,
                            labelText: Strings.loginString,
                          ),
                        ),
                      ),
                    ),

                    ///*-----SignUp-----*///
                    Container(
                      child: !_keyboardVisible
                          ? Expanded(
                              flex: 7,
                              child: Container(
                                child: TappableSubtitle(
                                  descriptionText: Strings.noAccount,
                                  actionText: Strings.kSignup,
                                  onActionTap: () => Navigator.pushNamed(
                                    context,
                                    SignUp.id,
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
