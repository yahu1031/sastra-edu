import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Components/largeHeading.dart';
import 'package:sastra_ebooks/Components/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';
import 'package:sastra_ebooks/Dialogs/dialogs.dart' as Dialogs;
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'mailus.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import '../Services/auth.dart';
import '../Misc/constants.dart';

import 'forgotpassword.dart';

class Login extends StatefulWidget {
  static const id = '/loginScreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String _regNum, _password;

  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  void logIn() async {
    if (_formKey.currentState.validate()) {
      Dialogs.showLoadingDialog(context);
      final User user = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context);
      if (_regNum.length < 9) {
        Dialogs.yesAbortDialog(
            context, kRegNumTooShortString, kRegNumTooShortExplainString);
      } else if (_password.length < 6) {
        Dialogs.yesAbortDialog(
            context, kPasswordTooShortString, kPasswordTooShortExplainString);
      } else if (user == null) {
        Dialogs.yesAbortDialog(
            context, kSorryString, kInvalidCredentialsExplainString);
      } else {
        Navigator.pushReplacementNamed(context, LoadingScreen.id,
            arguments: user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      ///*-----Login-Form-----*///
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///*-----Title -----*///
              LargeHeading(
                text: 'Hello\nThere',
                highlightText: ' .',
                size: Heading.extraLarge,
              ),

              SizedBox(height: 40),

              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ///*-----TextFormFields-----*///
                    RegNumTextFormField(
                      onChanged: (String _input) => setState(
                        () => _regNum = _input,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ///*-----Password-----*///
                    PasswordTextFormField(
                      onChanged: (String _input) {
                        setState(
                          () => _password = _input,
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    ///*-----Forgot Password-----*///
                    Align(
                      alignment: Alignment.topRight,
                      child: TappableText(
                        kForgotPasswordString,
                        onTap: () => Navigator.pushNamed(
                          context,
                          ForgotPassword.id,
                        ),
                      ),
                    ),

                    SizedBox(height: 60),

                    ///*-----Login Button-----*///
                    RoundedButton(
                      onPressed: logIn,
                      labelText: kLoginString,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 60,
              ),

              ///*-----MailUs Account-----*///
              TappableSubtitle(
                descriptionText: kCantFindAccString,
                actionText: kMailUsString,
                onActionTap: () => Navigator.pushNamed(
                  context,
                  MailUs.id,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
