import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/textFields/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Dialogs/dialogs.dart' as dialogs;
import 'package:sastra_ebooks/Services/user.dart';
import 'package:sastra_ebooks/loadingScreen.dart';

import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/Buttons/tappableSubtitle.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/Buttons/tappableText.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Components/Headings/largeHeading.dart';

import '../Misc/constants.dart';
import '../Services/auth.dart';
import 'forgotpassword.dart';
import '../Misc/screens/mailUs.dart';

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      ///*-----Login-Form-----*///
      body: SafeArea(
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

                    SizedBox(
                      height: 20,
                    ),

                    ///*-----Password-----*///
                    PasswordTextFormField(
                      onChanged: (String _input) => _password = _input,
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
