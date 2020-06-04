import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sastra_ebooks/Components/Buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/passwordTextFormField.dart';
import 'package:sastra_ebooks/Components/customTextFormField/children/regNumTextFormField.dart';
import 'package:sastra_ebooks/Components/tappableSubtitle.dart';
import 'package:sastra_ebooks/Components/tappableText.dart';
import 'package:sastra_ebooks/Services/user.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/misc/constants.dart';
import 'package:sastra_ebooks/loadingScreen.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/Dialogs/loadingDialog.dart';
import 'file:///F:/OneDrive/Desktop/eBooks/sastra-edu/lib/misc/textStyles.dart';
import 'mailus.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import '../Services/auth.dart';

import 'forgotpassword.dart';

class LoginTemplate extends StatefulWidget {
  final Function toggleView;
  final String title;

  LoginTemplate({this.title, this.toggleView});

  @override
  _LoginTemplateState createState() => _LoginTemplateState();
}

class _LoginTemplateState extends State<LoginTemplate>
    with SingleTickerProviderStateMixin {
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
              SizedBox(
                height: 20,
              ),
              RichText(
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
              SizedBox(height: 20),
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

                    SizedBox(height: 10),

                    ///*-----Forgot Password-----*///
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(top: 10, left: 5),
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
