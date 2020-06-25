import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/Buttons/tappableText.dart';
import 'package:sastra_ebooks/Components/Headings/largeHeading.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/Misc/constants.dart';
import 'package:sastra_ebooks/Misc/screens/signup.dart';
import 'package:sastra_ebooks/Services/auth.dart';
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/loadingScreen.dart';

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
      dialogs.showLoadingDialog(context);
      final User user = await _auth.signInWithEmailAndPassword(
        _regNum,
        _password,
      );
      Navigator.pop(context, true);
      if (_regNum.length < 9) {
        dialogs.yesAbortDialog(
            context, kRegNumTooShortString, kRegNumTooShortExplainString);
      } else if (_password.length < 6) {
        dialogs.yesAbortDialog(
            context, kPasswordTooShortString, kPasswordTooShortExplainString);
      } else if (user == null) {
        dialogs.yesAbortDialog(
            context, kSorryString, kInvalidCredentialsExplainString);
      } else {
        Navigator.pushReplacementNamed(context, LoadingScreen.id,
            arguments: user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomPadding: true,

      ///*-----Login-Form-----*///
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///*-----Title -----*///
                  LargeHeading(
                    text: 'Hello\nThere',
                    highlightText: ' .',
                    size: HeadingSize.extraLarge,
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
                          onChanged: (String _input) => _regNum = _input,
                        ),

                        SizedBox(height: 20),

                        ///*-----Password-----*///
                        PasswordTextFormField(
                          onChanged: (String _input) => _password = _input,
                        ),

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

                  SizedBox(height: 60),

                  ///*-----MailUs Account-----*///
                  TappableSubtitle(
                    descriptionText: kNoAccString,
                    actionText: kSignUpString,
                    onActionTap: () => Navigator.pushNamed(
                      context,
                      SignUp.id,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
