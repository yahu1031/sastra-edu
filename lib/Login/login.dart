import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/regNumbTextFormField.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/constants.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Dialogs/loadingDialog.dart';
import 'package:sastra_ebooks/textStyles.dart';
import 'mailus.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import '../Services/auth.dart';
import '../Services/Responsive/size_config.dart';

import 'forgotpassword.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  final String title;

  Login({this.title, this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  String _regNum, _password;

  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  void logIn() async {
    if (_formKey.currentState.validate()) {
      showLoadingDialog(context);
      final User user = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context);
      if (_regNum == null && _password == null) {
        Dialogs.yesAbortDialog(context, kSorryString,
            "Please fill the credentials. Credentials must not be empty.");
      } else if (_regNum == null) {
        Dialogs.yesAbortDialog(context, 'Register Number',
            "You are missing your Register number. please enter it.");
      } else if (_regNum.length < 9) {
        Dialogs.yesAbortDialog(context, 'Register Number',
            'Your register number must be 9 characters.');
      } else if (_password == null) {
        Dialogs.yesAbortDialog(context, 'Password',
            "You are missing your password. please enter it.");
      } else if (_password.length < 6) {
        Dialogs.yesAbortDialog(context, 'Password',
            'Your password must be more than 6 chasracters.');
      } else if (user == null) {
        Dialogs.yesAbortDialog(context, kSorryString,
            "Your credentials did not match. Please try with Correct credentials.");
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ///*-----Title -----*///
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 2 * SizeConfig.heightMultiplier,
                          top: 2 * SizeConfig.heightMultiplier,
                          left: 1 * SizeConfig.widthMultiplier),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Hello\nThere',
                              style: headline1TextStyle,
                            ),
                            TextSpan(
                              text: ' .',
                              style: headline1HighlightTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///*-----TextFormFields-----*///
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1 * SizeConfig.widthMultiplier,
                        vertical: 1 * SizeConfig.heightMultiplier,
                      ),
                      child: Column(
                        children: <Widget>[
                          ///*-----Reg Number-----*///
                          RegNumTextFormField(
                            onChanged: (String _input) => setState(
                              () => _regNum = _input,
                            ),
                          ),
                          SizedBox(
                            height: 5 * SizeConfig.heightMultiplier,
                          ),

                          ///*-----Password-----*///
                          PasswordTextFormField(
                            onChanged: (String _input) => setState(
                              () => _password = _input,
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier),

                          ///*-----Forgot Password-----*///
                          Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(
                                  top: SizeConfig.heightMultiplier,
                                  left: SizeConfig.widthMultiplier),
                              child: TappableText(
                                kForgotPasswordString,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  ForgotPassword.id,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 5 * SizeConfig.heightMultiplier),

                    ///*-----Login Button-----*///
                    RoundedButton(
                      onPressed: logIn,
                      labelText: kLogInString,
                    ),
                    SizedBox(height: 3 * SizeConfig.heightMultiplier),
                  ],
                ),
              ),
              /*-----MailUs Account-----*/
              Padding(
                padding: EdgeInsets.only(top: 3 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      kCantFindAccString,
                      style: subtitle1TextStyle,
                    ),
                    SizedBox(width: 10.0),
                    TappableText(
                      kMailUsString,
                      onTap: () => Navigator.pushNamed(context, MailUs.id),
                    )
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
